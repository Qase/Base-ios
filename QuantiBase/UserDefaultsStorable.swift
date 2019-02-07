//
//  UserDefaultsStorable.swift
//  ciggy-time
//
//  Created by Martin Troup on 11/04/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//

import Foundation

protocol UserDefaultsStorable {
	associatedtype Object

	static var key: String { get }

	func storeToUserDefaults()
	static func restoreFromUserDefaults() -> Object?
	func removeFromUserDefaults()
}
