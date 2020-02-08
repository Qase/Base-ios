//
//  UICollectionView+.swift
//  QuantiBase
//
//  Created by George Ivannikov on 1/21/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UICollectionView {

    var selectedIndexPaths: ControlEvent<[IndexPath]?> {
        let source: Observable<[IndexPath]?> = Observable.merge(self.itemSelected.asObservable(), self.itemDeselected.asObservable())
            .map { _ in self.base.indexPathsForSelectedItems }

        return ControlEvent(events: source)
    }

}
