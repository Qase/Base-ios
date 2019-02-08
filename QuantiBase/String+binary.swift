//
//  String+binary.swift
//  QuantiBase
//
//  Created by Martin Troup on 08/02/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

extension String {
	// Returns [UInt8] representation of self
	public var byteArray: [UInt8] {
		return self.utf8.reduce([UInt8](), { (uInt8Array, uInt8) -> [UInt8] in
			var _uInt8Array = uInt8Array
			_uInt8Array += [uInt8]

			return _uInt8Array
		})
	}
}
