//
//  UIImage+Resize.swift
//  2N-mobile-communicator
//
//  Created by Jakub Prusa on 29.11.16.
//  Copyright © 2016 quanti. All rights reserved.
//

import Foundation

// MARK: - Extension with resizing of image
extension UIImage {

    /// Resize UIImage and return it. 
    /// Using nice Swift 3.0 syntax for core graphic
    ///
    /// - Parameter newSize: CGSize aka new resolution
    /// - Returns: resized image
    public func with(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size:newSize)
        let image = renderer.image {_ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }

        return image
    }

}
