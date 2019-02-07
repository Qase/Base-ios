//
//  Data+.swift
//  BleFramework
//
//  Created by Martin Troup on 04/09/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import Foundation

extension Data {
	/// Returns [UInt8] representation of self
	public var byteArray: [UInt8] {
		return [UInt8](self)
	}

	/// Returns UInt8 on given position (due to the fact that Data can be represented as [UInt8]).
	///
	/// - Parameter position: of the byte to retrieve as UInt8
	/// - Returns: single UInt8
	public func uInt8(onPosition position: Int) -> UInt8? {
		guard position > 0, position < self.byteArray.count else {
			print("\(#function) - invalid position.")
			return nil
		}

		return self.byteArray[position]
	}

	/// Returns UInt16 on given position - due to the fact that Data can be represented as [UInt8] (native big-endian).
	///
	/// - Parameter position: of the first and following second byte to complete and retrieve as UInt16
	/// - Returns: single UInt16
	public func uInt16(onPosition position: Int) -> UInt16? {
		return [self.uInt8(onPosition: position), self.uInt8(onPosition: position + 1)].compactMap{ $0 }.uInt16
	}

	/// Returns UInt16 on given position - due to the fact that Data can be represented as [UInt8] (little-endian).
	///
	/// - Parameter position: of the first and following second byte to complete and retrieve as UInt16
	/// - Returns: single UInt16
	public func littleEndianUInt16(onPosition position: Int) -> UInt16? {
		return [self.uInt8(onPosition: position + 1), self.uInt8(onPosition: position)].compactMap{ $0 }.uInt16
	}

	/// Method to retrieve Data instance with random data of given length.
	///
	/// - Parameter length: of random data to be retrieved
	/// - Returns: random data of given length
	public static func randomData(ofLength length: Int = 16) -> Data {
		var data = Data()
		(0..<length).forEach { _ in
			_  = data.append(UInt8(arc4random_uniform(256)))
		}
		return data
	}
}
