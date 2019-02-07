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
		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)

//        blurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive=true
//        blurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive=true
//        blurEffectView.topAnchor.constraint(equalTo: self.topAnchor).isActive=true
//        blurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive=true
    }

	public func removeBlurEffect() {
		self.subviews.compactMap { $0 as? UIVisualEffectView }
			.forEach { $0.removeFromSuperview() }
	}
}
