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
        blurEffectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
