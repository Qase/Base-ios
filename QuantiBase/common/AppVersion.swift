//
//  AppVersion.swift
//  QuantiBase
//
//  Created by Martin Troup on 20/03/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

public struct AppVersion: Codable {
	public let major: Int
	public let minor: Int
	public let bug: Int

	public init?(from string: String) {
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

	public init(major: Int, minor: Int, bug: Int) {
		self.major = major
		self.minor = minor
		self.bug = bug
	}
}

// MARK: - Comparable implementation
extension AppVersion: Comparable {
	public static func < (lhs: AppVersion, rhs: AppVersion) -> Bool {
		return  (lhs.major < rhs.major) ||
			(lhs.major == rhs.major && lhs.minor < rhs.minor) ||
			(lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.bug < rhs.bug)
	}

	public static func == (lhs: AppVersion, rhs: AppVersion) -> Bool {
		return lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.bug == rhs.bug
	}
}

//// MARK: - UserDefaultsStorable implementation
//extension AppVersion: UserDefaultsStorable {
//    public var storableObject: AppVersion { return self }
//}
