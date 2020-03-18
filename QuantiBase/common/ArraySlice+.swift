//
//  ArraySlice+.swift
//  QuantiBase
//
//  Created by Martin Troup on 07/02/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

extension ArraySlice {
	// Converts self (ArraySlice) to Array instance.
	public var array: [Element] {
		Array(self)
	}
}
