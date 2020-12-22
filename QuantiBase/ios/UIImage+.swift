//
//  UIImage+.swift
//  2N-mobile-communicator
//
//  Created by Jakub Prusa on 29.11.16.
//  Copyright © 2016 quanti. All rights reserved.
//
#if canImport(UIKit)

import UIKit

// MARK: - Extension with resizing of image
extension UIImage {
    /// Resize UIImage and return it. 
    /// Using nice Swift 3.0 syntax for core graphic
    ///
    /// - Parameter newSize: CGSize aka new resolution
    /// - Returns: resized image
    public func resized(toSize newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image {_ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }

        return image
    }

	/// Method to resize the image to a specified height while keeping aspect ratio.
	///
	/// - Parameter newHeight: CGFloat to be resized to
	/// - Returns: resized image
	public func resized(toHeight newHeight: CGFloat) -> UIImage {
		let scale = newHeight / size.height
		let newWidth = size.width * scale

		return resized(toSize: CGSize(width: newWidth, height: newHeight))
	}

	// UIImage is only partially loaded when being created based on an image file (some kind of optimalization).
	// This property accesses it fully by hard-copying the image context.
	// NOTE: Should be avoided if possible!
	public var fullyLoaded: UIImage? {
		UIGraphicsBeginImageContext(self.size)
		self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage
	}
}
#endif
