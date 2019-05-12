//
//  CALayer+.swift
//  QuantiBase
//
//  Created by Martin Troup on 07/02/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import UIKit

extension CALayer {

	/// Method to add a unique animation to self (layer).
	/// Thus it gets removed first it if exists, and re-added after.
	///
	/// - Parameters:
	///   - animation: to be added
	///   - key: under which the animation will exist on the layer
	public func addUnique(_ animation: CAAnimation, forKey key: String) {
		removeAnimation(forKey: key)

		add(animation, forKey: key)
	}

	/// Method to pause all animations added to self (layer).
	public func pauseAnimations() {
		let pausedTime = self.convertTime(CACurrentMediaTime(), from: nil)
		self.speed = 0.0
		self.timeOffset = pausedTime
	}

	/// Method to resume all animations added to self (layer).
	public func resumeAnimations() {
		let pausedTime = self.timeOffset
		self.speed = 1.0
		self.timeOffset = 0.0
		let timeSincePause = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
		self.beginTime = timeSincePause
	}
}
