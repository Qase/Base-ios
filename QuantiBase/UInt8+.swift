//
//  UInt8+.swift
//  BleFramework
//
//  Created by Martin Troup on 17/09/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import Foundation

extension UInt8 {
	// Returns Data representation of self.
	public var data: Data {
		return [self].data
	}

}
