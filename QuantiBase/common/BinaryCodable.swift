//
//  BinaryCodable.swift
//  BleFramework
//
//  Created by Martin Troup on 14/09/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import Foundation

typealias BinaryCodable = BinarySerializable & BinaryDeserializable

public protocol BinarySerializable {
	var binary: [UInt8]? { get }
}

public protocol BinaryDeserializable {
	associatedtype Object

	static func deserialize(from data: [UInt8]) -> Object?
}
