//
//  PHAsset.swift
//  QuantiBase
//
//  Created by George Ivannikov on 1/21/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//
#if canImport(UIKit)

import Foundation
import UIKit
import Photos
import QuantiLogger

extension PHAsset {
    func getAssetThubnail(size: CGSize = CGSize(width: 240, height: 352)) -> UIImage {
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

    var size: Int? {
        guard let uploadFileURL = url else {
            return nil
        }
        let size = uploadFileURL.fileSize
        do {
            try FileManager.default.removeItem(at: uploadFileURL)
        } catch {
            QLog("Error deleting file for screenshot", onLevel: .error)
            return nil
        }

        return size
    }

    var url: URL? {
        let image = getAssetThubnail(size: CGSize(width: 720, height: 1080))
        let imageData = image.pngData()
        let uploadKeyName = image.accessibilityIdentifier
        let uploadFileURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + ((uploadKeyName ?? String.random()) + ".png"))
        if FileManager.default.fileExists(atPath: uploadFileURL.absoluteString) {
            do {
                try FileManager.default.removeItem(at: uploadFileURL)
            } catch {
                QLog("Error deleting file for screenshot", onLevel: .error)
                return nil
            }
        }
        do {
            try imageData?.write(to: uploadFileURL)
        } catch {
            QLog("Error rewriting file for screenshot", onLevel: .error)
            return nil
        }

        return uploadFileURL
    }

}
#endif
