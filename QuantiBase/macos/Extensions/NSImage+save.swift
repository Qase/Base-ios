//
//  NSImage+save.swift
//  QuantiBase macOS
//
//  Created by Martin Troup on 16/05/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Cocoa

extension NSImage {
    public func save(to path: URL) {
        guard let cgImage = cgImage(forProposedRect: nil, context: nil, hints: nil) else { return }
        let bitmap = NSBitmapImageRep(cgImage: cgImage)
        bitmap.size = size
        guard let data = bitmap.representation(using: .png, properties: [:]) else {
            QuantiBaseEnv.current.logger.log("ERROR: Image not saved. Bitmap representation failed.", onLevel: .error)
            return
        }
        do {
            try data.write(to: path)
        } catch {
            QuantiBaseEnv.current.logger.log("ERROR: Image not saved", onLevel: .error)
        }
    }
}
