//
//  AnimationFactory.swift
//  QuantiBase
//
//  Created by Martin Troup on 07/02/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import UIKit

public struct AnimationFactory {
	public enum RotationDirection {
		case left
		case right
	}

	public static func rotation(toDirection direction: RotationDirection = .right, withDuration duration: CFTimeInterval = 1.5, repeatCount: Float = Float.infinity) -> CAAnimation {
		let animationGroup = CAAnimationGroup()
		animationGroup.duration =  1.5
		animationGroup.beginTime = 0.0
		animationGroup.repeatCount = Float.infinity
		animationGroup.isRemovedOnCompletion = false

		let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")

		rotateAnimation.fromValue = CGFloat(0.0).radians
		switch direction {
		case .right:
			rotateAnimation.toValue = CGFloat(360).radians
		case .left:
			rotateAnimation.toValue = -CGFloat(360).radians
		}

		animationGroup.animations = [rotateAnimation]

		return animationGroup
	}

	public static func progress(from: CGFloat, to: CGFloat, withDuration duration: CFTimeInterval = 0.5) -> CAAnimation {
		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.duration = duration
		animation.fromValue = from
		animation.toValue = to
		animation.isRemovedOnCompletion = false
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

		return animation
	}

	public static func colorPulsing(fromColor: UIColor, toColor: UIColor) -> CAAnimation {
		let animation = CAKeyframeAnimation(keyPath: "strokeColor")
		animation.duration = 2.0
		animation.beginTime = 0.0
		animation.repeatCount = Float.infinity
		animation.isRemovedOnCompletion = false

		animation.keyTimes = [0.0, 0.5, 1.0]
		animation.values = [
			fromColor.cgColor,
			toColor.cgColor,
			fromColor.cgColor
		]

		return animation
	}
}
