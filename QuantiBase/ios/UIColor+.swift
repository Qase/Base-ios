//
//  UIColor+.swift
//  QuantiBase
//
//  Created by David Nemec on 17/08/2017.
//  Copyright © 2017 David Nemec. All rights reserved.
//
#if canImport(UIKit)

import UIKit

extension UIColor {
    /// Returns a rectangular image filled with the color.
    ///
    /// - Parameter size: of the image
    /// - Returns: instance of UIImage
    public func imageFromColor(of size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

	/// Returns color, whose color parts (r, g, b) are set to x% of the original values.
	///
	/// - Parameter percentage: of the original values of color parts to be set
	/// - Returns: new instance of UIColor
	public func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
		var r: CGFloat=0, g: CGFloat=0, b: CGFloat=0, a: CGFloat=0

		guard self.getRed(&r, green: &g, blue: &b, alpha: &a) else { return nil }

		return UIColor(red: min(r + percentage / 100, 1.0),
					   green: min(g + percentage / 100, 1.0),
					   blue: min(b + percentage / 100, 1.0),
					   alpha: a)
	}

	public var highlighted: UIColor {
		self.darker() ?? .black
	}

	public func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
		self.adjust(by: abs(percentage))
	}

	public func darker(by percentage: CGFloat = 30.0) -> UIColor? {
		self.adjust(by: -1 * abs(percentage))
	}
}

extension UIColor {
    public class var textGrey: UIColor {
        UIColor(red: 164/255.0, green: 164/255.0, blue: 167/255.0, alpha: 1)
    }
}
#endif
