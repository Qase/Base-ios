//
//  UserDefaultsStorable.swift
//  ciggy-time
//
//  Created by Martin Troup on 11/04/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//

import Foundation

public struct UserDefaultsBundle {
	let key: String
	let storage: UserDefaults
}

public protocol UserDefaultsStorable {
	func store(using userDefaultsBundle: UserDefaultsBundle) -> Bool
	init?(using userDefaultsBundle: UserDefaultsBundle)
	func remove(using userDefaultsBundle: UserDefaultsBundle)
}

extension UserDefaultsStorable {
	func remove(using userDefaultsBundle: UserDefaultsBundle) {
		userDefaultsBundle.storage.removeObject(forKey: userDefaultsBundle.key)
	}
}

// MARK: - Extension for UserDefaults providing functionality of storing / restoring data as JSON using JSONEncoder.
extension UserDefaults {
	func set<T: Codable>(object: T, forKey key: String) -> Bool {
		do {
			let jsonEncoder = JSONEncoder()
			let data = try jsonEncoder.encode(object)
			self.set(data, forKey: key)
			return true
		} catch let error {
			print("\(#function) - error ocurred while encoding to JSON: \(error).")
			return false
		}
	}

	func object<T: Codable>(forKey key: String) -> T? {
		do {
			guard let data = self.data(forKey: key) else {
				print("\(#function) - could not retrieve data from UserDefaults.")
				return nil
			}

			let jsonDecoder = JSONDecoder()
			return try jsonDecoder.decode(T.self, from: data)
		} catch let error {
			print("\(#function) - error ocurred while decoding from JSON: \(error).")
			return nil
		}
	}
}
