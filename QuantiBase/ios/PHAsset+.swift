//
//  PHAsset.swift
//  QuantiBase
//
//  Created by George Ivannikov on 1/21/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension PHAsset {
    func getAssetThubnail(size: CGSize = CGSize(width: 1080, height: 1920)) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.deliveryMode = .highQualityFormat
        option.isSynchronous = true
        var thumbnail = UIImage()
        manager.requestImage(for: self,
                             targetSize: size,
                             contentMode: .aspectFit,
                             options: option,
                             resultHandler: {(result, _) -> Void in
            thumbnail = result ?? UIImage()
        })
        return thumbnail
    }
}
