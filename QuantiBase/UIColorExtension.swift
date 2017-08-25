//
//  UIColorExtension.swift
//  QuantiBase
//
//  Created by David Nemec on 17/08/2017.
//  Copyright © 2017 David Nemec. All rights reserved.
//

//
//  UIColorExtension.swift
//  2N-push-notification-app
//
//  Created by Martin Troup on 03.10.16.
//  Copyright © 2016 Martin Troup. All rights reserved.
//

import UIKit

extension UIColor {
    // Cust functions
    public func getImageFromColor(size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    public func getImageFromColor() -> UIImage {
        return getImageFromColor(size: CGSize(width: 1, height: 1))
    }

    public class var grayText: UIColor {
        return UIColor(red: 164/255.0, green: 164/255.0, blue: 167/255.0, alpha: 1)
    }

}
