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

    public init(key: String, storage: UserDefaults) {
        self.key = key
        self.storage = storage
    }
}

public protocol UserDefaultsStorable {
	associatedtype StorableObject: Codable

	var storableObject: StorableObject { get }

    static var defaultStorageKey: String? { get }

	func store(using userDefaultsBundle: UserDefaultsBundle) -> Bool
	static func restore(using userDefaultsBundle: UserDefaultsBundle) -> StorableObject?
	func remove(using userDefaultsBundle: UserDefaultsBundle)
}

extension UserDefaultsStorable {
    public static var defaultStorageKey: String? {
        return nil
    }

	public func store(using userDefaultsBundle: UserDefaultsBundle) -> Bool {
		return userDefaultsBundle.storage.set(object: Wrapper(value: storableObject), forKey: userDefaultsBundle.key)
	}

	public static func restore(using userDefaultsBundle: UserDefaultsBundle) -> StorableObject? {
		guard let restored: Wrapper<StorableObject> = userDefaultsBundle.storage.object(forKey: userDefaultsBundle.key) else {
			print("\(#function) - failed to restore StorableObject instance from UserDefaults.")
			return nil
		}

		return restored.value
	}

	public func remove(using userDefaultsBundle: UserDefaultsBundle) {
		userDefaultsBundle.storage.removeObject(forKey: userDefaultsBundle.key)
	}
}

// Generic structure being used to wrap primitive types since these cannot be encoded using JSONEncoder or any other Swift native encoder.
// - known Swift bug: https://bugs.swift.org/browse/SR-6163
public struct Wrapper<T: Codable>: Codable {
	public let value: T
}

// MARK: - Extension for UserDefaults providing functionality of storing / restoring data as JSON using JSONEncoder.
extension UserDefaults {
	public func set<T: Codable>(object: T, forKey key: String) -> Bool {
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

	public func object<T: Codable>(forKey key: String) -> T? {
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
