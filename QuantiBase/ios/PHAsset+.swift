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
    func getAssetThubnail(size: CGSize = CGSize(width: 75, height: 150)) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.version = .original
        option.isSynchronous = true
        var thumbnail = UIImage()
//        manager.requestImage(for: self,
//                             targetSize: size,
//                             contentMode: .aspectFit,
//                             options: option,
//                             resultHandler: {(result, _) -> Void in
//                                thumbnail = result ?? UIImage()
//        })
        manager.requestImageData(for: self, options: option, resultHandler: { data, _, _, _ in
            if let data = data {
                thumbnail = resizeImage(image: UIImage(data: data) ?? UIImage(),
                                        targetSize: size)
            }
        })
        return thumbnail
    }
}

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size

    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height

    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }

    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
}
