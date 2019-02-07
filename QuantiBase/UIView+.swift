//
//  UIView+.swift
//  2N-push-notification-app
//
//  Created by Martin Troup on 05.10.16.
//  Copyright © 2016 Martin Troup. All rights reserved.
//

import UIKit

extension UIView {
    /// Method to remove all subviews of a specific view.
    public func removeAllSubviews() {
        removeAllSubviews(from: self)
    }

    private func removeAllSubviews(from view: UIView) {
        for subview in view.subviews {
            removeAllSubviews(from: subview)
            if subview.superview != nil {
                subview.removeFromSuperview()
            }
        }
    }

	/// Ads blur effect to the view.
	///
	/// - Parameter style: style of the blur effect
	public func addBlurEffect(withStyle style: UIBlurEffect.Style = .light) {
		let blurEffect = UIBlurEffect(style: style)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = self.bounds

		// supporting device rotation
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.addSubview(blurEffectView)
	}

	/// Removes all blur effects on the view and its subviews
	public func removeAllBlurEffects() {
		removeAllBlurEffects(from: self)
	}

	private func removeAllBlurEffects(from view: UIView) {
		view.subviews.forEach { subview in
			removeAllBlurEffects(from: subview)
			if let _subview = subview as? UIVisualEffectView {
				_subview.removeFromSuperview()
			}
		}
	}

    /// Adds background horizontal gradient to the view.
    ///
    /// - Parameters:
    ///   - bottomColor: bottom color of the gradient
    ///   - topColor: top color of the gradient
    public func addBackgroundHorizontalGradient(withBottomColor bottomColor: UIColor, withTopColor topColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = frame
        gradientLayer.zPosition = -1

        self.layer.addSublayer(gradientLayer)
    }
}
