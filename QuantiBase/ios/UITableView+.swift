//
//  UITableView+.swift
//  QuantiBase
//
//  Created by Dagy Tran on 05/11/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//
#if canImport(UIKit)

import UIKit
import RxSwift
import RxCocoa
import Overture

extension Reactive where Base: UITableView {
    public var selectedIndexPaths: ControlEvent<[IndexPath]> {
        let source: Observable<[IndexPath]> = Observable.merge(self.itemSelected.asObservable(), self.itemDeselected.asObservable())
            .map { _ in self.base.indexPathsForSelectedRows ?? [] }

        return ControlEvent(events: source)
    }
}

extension UITableView {
    public func selectAllRows(_ inSection: Int = 0) {
        (0..<numberOfRows(inSection: inSection))
            .map(flip(curry(IndexPath.init(row:section:)))(inSection))
            .forEach {
                selectRow(at: $0, animated: true, scrollPosition: .none)
                delegate?.tableView?(self, didSelectRowAt: $0)
        }
    }

    public func deselectAllRows(_ animated: Bool = false) {
        indexPathsForSelectedRows?.forEach {
            deselectRow(at: $0, animated: animated)
            delegate?.tableView?(self, didDeselectRowAt: $0)
        }
    }
}
#endif
