//
//  UIViewExtension.swift
//  2N-push-notification-app
//
//  Created by Martin Troup on 05.10.16.
//  Copyright © 2016 Martin Troup. All rights reserved.
//

import UIKit

public enum RotationDirection {
    case left, right
}

extension UIView {

    /// Method to remove all subviews of a specific view.
    public func removeAllSubviews() {
        removeAllSubviews(from: self)
//        for view in self.subviews {
//            view.removeFromSuperview()
//        }
    }
    private func removeAllSubviews(from view: UIView) {
        for subview in view.subviews {
            removeAllSubviews(from: subview)
            if subview.superview != nil {
                subview.removeFromSuperview()
            }
        }
    }

    public var isHiddenGuarded: Bool {
        get {
            return isHidden
        }

        set {
            if newValue == isHidden {
                return
            }
            isHidden = newValue
        }
    }

    public static func dummyViewWith(height: Int) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: CGFloat(height))

        return view
    }

    public static func dummyViewWith(width: Int) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: CGFloat(width))

        return view
    }

    public func dummyViewWith(priority: Int) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 1).priority = Float(priority)
        
        return view
    }

    public func addBackgroundHorizontalGradient(withBottomColor bottomColor: UIColor, withTopColor topColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = frame
        gradientLayer.zPosition = -1

        self.layer.addSublayer(gradientLayer)
    }

    public func animateRotation(withDuration duration: CFTimeInterval, withDirection direction: RotationDirection) {
        let rotationKey = "rotation"
        if self.layer.animation(forKey: rotationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = direction == .right ? Float(Double.pi * 2.0) : -Float(Double.pi * 2.0)
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            rotationAnimation.isRemovedOnCompletion = false

            self.layer.add(rotationAnimation, forKey: rotationKey)
        }
    }
}
