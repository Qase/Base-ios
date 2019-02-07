//
//  AnimationFactory.swift
//  QuantiBase
//
//  Created by Martin Troup on 07/02/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

struct AnimationFactory {
	public enum RotationDirection {
		case left
		case right
	}

	/// Infinite rotation.
	///
	/// - Parameters:
	///   - duration: duration of a single 360° rotation
	///   - direction: direction of the rotation
	/// - Returns: desired rotation animation that can be added to a view
	static func infiniteRotation(withDuration duration: CFTimeInterval, withDirection direction: RotationDirection) -> CABasicAnimation {
		let infiniteRotation = CABasicAnimation(keyPath: "transform.rotation")

		infiniteRotation.fromValue = 0.0
		switch direction {
		case .right:
			infiniteRotation.toValue = Float(Double.pi * 2.0)
		case .left:
			infiniteRotation.toValue = -Float(Double.pi * 2.0)
		}

		infiniteRotation.duration = duration
		infiniteRotation.repeatCount = Float.infinity
		infiniteRotation.isRemovedOnCompletion = false

		return infiniteRotation
	}
}
