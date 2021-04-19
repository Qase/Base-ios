//
//  UserDefaultsStorable.swift
//  ciggy-time
//
//  Created by Martin Troup on 11/04/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "Use methods set(encodable:forKey) and decodable(forKey:) on an instance of UserDefaults instead.")
public struct UserDefaultsBundle {
	let key: String
	let storage: UserDefaults

    public init(key: String, storage: UserDefaults) {
        self.key = key
        self.storage = storage
    }
}

@available(*, deprecated, message: "Use methods set(encodable:forKey) and decodable(forKey:) on an instance of UserDefaults instead.")
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
        nil
    }

	public func store(using userDefaultsBundle: UserDefaultsBundle) -> Bool {
        userDefaultsBundle.storage.set(codable: storableObject, forKey: userDefaultsBundle.key)
	}

	public static func restore(using userDefaultsBundle: UserDefaultsBundle) -> StorableObject? {
		guard let restored: StorableObject = userDefaultsBundle.storage.codable(forKey: userDefaultsBundle.key) else {
            QuantiBaseEnv.current.logger.log("\(#function) - failed to restore StorableObject instance from UserDefaults.", onLevel: .error)
			return nil
		}

		return restored
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

// MARK: - Extension for UserDefaults providing functionality of storing / restoring Encoding / Decoding types as JSON using JSONEncoder.
extension UserDefaults {
	public func set<T: Codable>(codable: T, forKey key: String) -> Bool {
		do {
            let wrapped = Wrapper(value: codable)
			let jsonEncoder = JSONEncoder()
            let data = try jsonEncoder.encode(wrapped)
			self.set(data, forKey: key)
            return true
		} catch let error {
            QuantiBaseEnv.current.logger.log("\(#function) - error ocurred while encoding to JSON: \(error).", onLevel: .error)
			return false
		}
	}

	public func codable<T: Codable>(forKey key: String) -> T? {
		do {
			guard let data = self.data(forKey: key) else {
                QuantiBaseEnv.current.logger.log("\(#function) - could not retrieve data from UserDefaults.", onLevel: .error)
				return nil
			}

			let jsonDecoder = JSONDecoder()
            let restored = try jsonDecoder.decode(Wrapper<T>.self, from: data)
			return restored.value
		} catch let error {
            QuantiBaseEnv.current.logger.log("\(#function) - error ocurred while decoding from JSON: \(error).", onLevel: .error)
			return nil
		}
	}
}
