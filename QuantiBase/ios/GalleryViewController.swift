//
//  GalleryViewController.swift
//  QuantiBase
//
//  Created by George Ivannikov on 1/21/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Photos
import SnapKit

struct GalleryScreenshots {
    let header: String
    var items: [Item]
}

extension GalleryScreenshots: AnimatableSectionModelType {
    typealias Item = PHAsset

    var identity: String { return header }

    init(original: GalleryScreenshots, items: [Item]) {
        self = original
        self.items = items
    }
}

extension PHAsset: IdentifiableType {
    public typealias Identity = String

    public var identity: String { return localIdentifier }
}

public class ScreenshotsGalleryViewController: UIViewController {
    private var closeBarButton = UIBarButtonItem(title: "close_button".localized, style: .plain, target: nil, action: nil)
    private let selectBarButton = UIBarButtonItem(title: "select".localized, style: .plain, target: nil, action: nil)
    private var collectionView: PanSelectableCollectionView!

    private var galleryPhotos = BehaviorRelay<[PHAsset]?>(value: [])
    private let galleryPhotosSubject = PublishSubject<[GalleryScreenshots]>()
    private lazy var galleryPhotosObservable: Observable<[GalleryScreenshots]> = {
        galleryPhotosSubject.asObservable()
    }()
    public let selectedPhotosSubject = PublishSubject<[PHAsset]>()
    private lazy var areScreenshotsSelected: Observable<Bool> = {
        collectionView.rx.selectedIndexPaths.asObservable()
            .map { $0?.count ?? 0 > 0 }
    }()
    private let bag = DisposeBag()

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupBinding()
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                let fetchOptions = PHFetchOptions()
                let allGalleryPhotos: PHFetchResult<PHAsset>? = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                guard let photosCount = allGalleryPhotos?.count, photosCount > 0 else {
                    return
                }
                let photos = allGalleryPhotos?.objects(at: IndexSet(0...photosCount - 1))
                    .filter { $0.mediaSubtypes == .photoScreenshot }
                self.galleryPhotos.accept(photos)
                if let photos = photos {
                    let galleryPhotos = [GalleryScreenshots(header: "gallery", items: photos)]
                    self.galleryPhotosSubject.onNext(galleryPhotos)
                }
            default:
                break
            }
        }
    }

    private func setupLayout() {
        title = "snapshot_gallery".localized
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = closeBarButton
        selectBarButton.isEnabled = false
        navigationItem.rightBarButtonItem = selectBarButton
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 5
        collectionViewLayout.minimumInteritemSpacing = 2
        collectionViewLayout.estimatedItemSize = CGSize(width: 50, height: 100)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: collectionViewLayout.minimumLineSpacing, left: 0, bottom: 0, right: 0)

        let collectionView = PanSelectableCollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        collectionView.register(CallLogSnapshotCollectionViewCell.self, forCellWithReuseIdentifier: "CallLogSnapshotCollectionViewCell")

        collectionView.backgroundColor = .white
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        collectionView.maxSelectedItems = 5
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }

        self.collectionView = collectionView
    }

    private func setupBinding() {
        closeBarButton.rx.tap
            .do(onNext: { [weak self] in self?.dismiss(animated: true, completion: nil) })
            .subscribe()
            .disposed(by: bag)

        selectBarButton.rx.tap
            .do(onNext: { [weak self] in
                let selectedPhotos = self?.collectionView.indexPathsForSelectedItems?.map { self?.galleryPhotos.value?[$0.row] }
                guard let selectedPhotosAssets = selectedPhotos as? [PHAsset] else {
                    return
                }
                self?.selectedPhotosSubject.onNext(selectedPhotosAssets)
                self?.dismiss(animated: true, completion: nil)
            })
            .subscribe()
            .disposed(by: bag)

        areScreenshotsSelected
            .bind(to: selectBarButton.rx.isEnabled)
            .disposed(by: bag)

        let dataSource = RxCollectionViewSectionedAnimatedDataSource<GalleryScreenshots>(
            configureCell: { (_, collectionView, indexPath, phasset) in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CallLogSnapshotCollectionViewCell", for: indexPath) as? CallLogSnapshotCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.isSelected = false
                cell.contentView.backgroundColor = .red
                cell.snapshot = phasset.getAssetThubnail()
                return cell
        })

        galleryPhotosObservable
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }

}
