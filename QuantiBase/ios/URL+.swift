//
//  URL+.swift
//  QuantiBase
//
//  Created by George Ivannikov on 3/17/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//

import Foundation
import QuantiLogger

extension URL {
    var fileSize: Int? {
        do {
            let resources = try self.resourceValues(forKeys: [.fileSizeKey])
            let fileSize = resources.fileSize

            return fileSize
        } catch {
            QLog("File size recognition error", onLevel: .error)
            return nil
        }
    }
}
