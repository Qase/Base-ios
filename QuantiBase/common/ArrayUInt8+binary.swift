//
//  ArrayUInt8+binary.swift
//  BleFramework
//
//  Created by Martin Troup on 17/09/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import Foundation

extension Array where Element == UInt8 {

	/// Returns Data representation of self.
	public var data: Data {
		Data(self)
	}

	/// Converts self = [UInt8] consisting of 2xUInt8 to UInt16 (native big-endian).
	public var uInt16: UInt16? {
		guard self.count == 2 else {
            QuantiBaseEnv.current.logger.log("\(#function) - [UInt8] must consist, exactly, of 2xUInt8 so it can be converted to single UInt16.", onLevel: .error)
			return nil
		}

		return UInt16(self[0]) << 8 | UInt16(self[1])
	}

	/// Converts self = [UInt8] consisting of 2xUInt8 to UInt16 (little-endian).
	public var littleEndianUInt16: UInt16? {
		self.reversed().uInt16
	}

	/// Converts self to String.
	public var string: String? {
		String(bytes: self, encoding: .utf8)
	}
}
