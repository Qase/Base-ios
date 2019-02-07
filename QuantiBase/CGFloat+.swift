//
//  CGFloat+.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 13.02.17.
//  Copyright © 2017 quanti. All rights reserved.
//

import Foundation

extension CGFloat {

    /// Scaling system for different screen resolutions
    public var scaled: CGFloat {
        switch UIDevice.type.resolutionGroup! {
        case .lr320x568:
            return self
        case .lr375x667:
            return self * 1.1
        case .lr414x736:
            return self * 1.2
        case .lr768x1024:
            return self * 1.3
        // For iPads
        case .lr1024x1366:
            return self * 1.3
        }
    }


	/// Radians representation of self
	public var radians: CGFloat {
		return self * CGFloat(Double.pi) / 180.0
	}
}
