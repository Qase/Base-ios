//
//  AppVersion.swift
//  QuantiBase
//
//  Created by Martin Troup on 20/03/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

struct AppVersion: Codable {
	let major: Int
	let minor: Int
	let bug: Int

	init?(from string: String) {
		let elements = string.split(separator: ".")
		guard elements.count == 3,
			let major = Int(elements[0]),
			let minor = Int(elements[1]),
			let bug = Int(elements[2]) else {
			return nil
		}

		self.major = major
		self.minor = minor
		self.bug = bug
	}

	init(major: Int, minor: Int, bug: Int) {
		self.major = major
		self.minor = minor
		self.bug = bug
	}
}

// MARK: - Comparable implementation
extension AppVersion: Comparable {
	static func < (lhs: AppVersion, rhs: AppVersion) -> Bool {
		return  (lhs.major < rhs.major) ||
			(lhs.major == rhs.major && lhs.minor < rhs.minor) ||
			(lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.bug < rhs.bug)
	}

	static func == (lhs: AppVersion, rhs: AppVersion) -> Bool {
		return lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.bug == rhs.bug
	}
}

// MARK: - UserDefaultsStorable implementation
extension AppVersion: UserDefaultsStorable {
	func store(using userDefaultsBundle: UserDefaultsBundle) -> Bool {
		return userDefaultsBundle.storage.set(object: self, forKey: userDefaultsBundle.key)
	}

	init?(using userDefaultsBundle: UserDefaultsBundle) {
		let restored: AppVersion? = userDefaultsBundle.storage.object(forKey: userDefaultsBundle.key)

		guard let _restored = restored else {
			print("\(#function) - failed to restore AppVersion instance from UserDefaults.")
			return nil
		}

		self = _restored
	}

}
