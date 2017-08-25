//
//  UIImageViewExtension.swift
//  2N-mobile-communicator
//
//  Created by David Nemec on 23/11/2016.
//  Copyright © 2016 quanti. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)

        blurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        blurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        blurEffectView.topAnchor.constraint(equalTo: self.topAnchor)
        blurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    }
}
