//
//  UInt16+binary.swift
//  QuantiBase
//
//  Created by Martin Troup on 07/02/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

extension UInt16 {
	// Returns Data representation of self.
	public var data: Data {
		Data(self.byteArray)
	}

	/// Returns [UInt8] representation of self (native big-endian).
	public var byteArray: [UInt8] {
		[UInt8(self >> 8), UInt8(self & 0x00ff)]
	}

	/// Returns [UInt8] representation of self (little-endian).
	public var littleEndianBytes: [UInt8] {
		byteArray.reversed()
	}

	/// Returns Int representation of self.
	public var int: Int {
		Int(self)
	}
}
