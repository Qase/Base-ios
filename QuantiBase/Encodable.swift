//
//  File.swift
//  2N-mobile-communicator
//
//  Created by Jakub Prusa on 11.07.17.
//  Copyright © 2017 quanti. All rights reserved.
//

import Foundation

// MARK: - Encodable
public protocol Encodable {
  init?(data: Data)

  func encode() -> Data
}

// MARK: - DictionaryEncodable
public protocol DictionaryEncodable: Encodable {
  init?(dictionary: [AnyHashable: Any])

  func toDictionary() -> [AnyHashable: Any]
}

extension DictionaryEncodable {

  public func encode() -> Data {
    let dictionary = toDictionary()
    return NSKeyedArchiver.archivedData(withRootObject: dictionary)
  }

  public init?(data: Data) {
    guard let dictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as? [AnyHashable: Any] else {
      return nil
    }
    self.init(dictionary: dictionary)
  }

  public init?(jsonData data: Data) {
    guard let jsonObject = try? JSONSerialization.jsonObject(with: data),
      let dictionary = jsonObject as? [AnyHashable: Any] else {
        return nil
    }
    self.init(dictionary: dictionary)
  }

}
