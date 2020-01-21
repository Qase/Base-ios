//
//  PanSelectableCollectionView.swift
//  QuantiBase
//
//  Created by George Ivannikov on 1/21/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class PanSelectableCollectionView: UICollectionView {
    private let bag = DisposeBag()
    public let canPanRelay = BehaviorRelay(value: false)
    var canPan: Bool { return canPanRelay.value }
    var maxSelectedItems: Int?

    private let panGesturePublisher = PublishRelay<UIPanGestureRecognizer>()

    private var selectedIndexSet = IndexSet([])

    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        delegate = self
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanToSelectCells))
        panRecognizer.delegate = self
        addGestureRecognizer(panRecognizer)

        setupBinding()
    }

    private func setupBinding() {
        let panGestureObservable = panGesturePublisher.filter { [weak self] _ in self?.canPan ?? false }.share()

        // Enabling scroll
        panGestureObservable
            .map { ![.began, .changed].contains($0.state) }
            .distinctUntilChanged()
            .bind(to: self.rx.isScrollEnabled)
            .disposed(by: bag)

        panGestureObservable
            .map { $0.state == .ended }
            .filter { $0 }
            .do(onNext: { [weak self] _ in
                self?.selectedIndexSet = IndexSet(self?.indexPathsForSelectedItems?.map { $0.row } ?? [])
            })
            .subscribe()
            .disposed(by: bag)

        setupSavingIndexPaths(panGestureObservable)
    }

    private func setupSavingIndexPaths(_ panGestureObservable: Observable<UIPanGestureRecognizer>) {
        let toIndexPath: (Int) -> IndexPath = { IndexPath(row: $0, section: 0) }

        let toIndexPathArray: ((begin: Int, end: Int)) -> [IndexPath] = { arg in
            let (begin, end) = arg
            guard begin >= 0, end >= 0 else {
                return []
            }

            // End can be lower than begin if the pan finishes on a cell before the starting cell
            return (min(begin, end)...max(begin, end)).map(toIndexPath)
        }

        panGestureObservable
            .scan(nil, accumulator: { [weak self] indexPathTuple, panGesture -> (Int, Int)? in
                guard let self = self,
                    let indexOfGestureLocation = self.indexPathForItem(at: panGesture.location(in: self))?.row else {
                    return indexPathTuple
                }

                switch panGesture.state {
                case .began:
                    return (indexOfGestureLocation, indexOfGestureLocation)
                case .changed, .ended:
                    guard let indexPathTuple = indexPathTuple else {
                        return nil
                    }

                    return (indexPathTuple.0, indexOfGestureLocation)
                default:
                    return nil
                }
            })
            .filterNil()
            .distinctUntilChanged { $0.0 == $1.0 && $0.1 == $1.1 }
            .map(toIndexPathArray)
            .do(onNext: { [weak self] selectedIndexPaths in
                guard let self = self else {
                    return
                }

                selectedIndexPaths.forEach(self.selectItem)

                // Deselect everything else
                let currentlySelectedIndexSet = self.selectedIndexSet.union(IndexSet(selectedIndexPaths.map { $0.row }))
                let completeIndexSet = IndexSet(0..<self.numberOfItems(inSection: 0))
                completeIndexSet.subtracting(currentlySelectedIndexSet).map(toIndexPath).forEach(self.deselectItem)
            })
            .subscribe()
            .disposed(by: bag)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didPanToSelectCells(_ panGesture: UIPanGestureRecognizer) {
        panGesturePublisher.accept(panGesture)
    }

    override public func selectItem(at indexPath: IndexPath?, animated: Bool, scrollPosition: UICollectionView.ScrollPosition) {
        super.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)

        guard let indexPath = indexPath else { return }

        delegate?.collectionView?(self, didSelectItemAt: indexPath)
    }

    func selectItem(at indexPath: IndexPath) {
        selectItem(at: indexPath, animated: true, scrollPosition: [])
    }

    override public func deselectItem(at indexPath: IndexPath, animated: Bool) {
        super.deselectItem(at: indexPath, animated: animated)
        delegate?.collectionView?(self, didDeselectItemAt: indexPath)
    }

    func deselectItem(at indexPath: IndexPath) {
        deselectItem(at: indexPath, animated: true)
    }

    override public func deleteItems(at indexPaths: [IndexPath]) {
        super.deleteItems(at: indexPaths)
        selectedIndexSet.removeAll()
    }
}

extension PanSelectableCollectionView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension PanSelectableCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let maxSelectedItems = maxSelectedItems, let selectedItemsCount = indexPathsForSelectedItems?.count {
            return selectedItemsCount < maxSelectedItems
        }
        return true
    }
}
