//
//  GalleryScreenshots.swift
//  QuantiBase
//
//  Created by George Ivannikov on 2/26/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import RxDataSources
import Photos

struct GalleryScreenshots {
    let header: String
    var items: [Item]
}

extension GalleryScreenshots: AnimatableSectionModelType {
    typealias Item = Screenshot

    var identity: String { header }

    init(original: GalleryScreenshots, items: [Item]) {
        self = original
        self.items = items
    }
}

public struct Screenshot {
    let asset: PHAsset
}

extension Screenshot: Equatable {
    public static func == (lhs: Screenshot, rhs: Screenshot) -> Bool {
        lhs.identity == rhs.identity
    }
}

extension Screenshot: IdentifiableType {
    public typealias Identity = String

    public var identity: String { asset.description }
}
#endif
