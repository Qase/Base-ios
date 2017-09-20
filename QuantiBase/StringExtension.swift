//
//  StringExtension.swift
//  QuantiBase
//
//  Created by David Nemec on 17/08/2017.
//  Copyright © 2017 David Nemec. All rights reserved.
//

import Foundation

extension String {

    /// Replaces all occurances from string with replacement
    /// No rocket science here, just wraping existing code into shorter method :)
    ///
    /// - Parameters:
    ///   - string: string to replacement
    ///   - replacement: replacement
    /// - Returns: final string
    public func replace(_ string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: .literal, range: nil)
    }


    /// Subscript to get char on specific index: "Hello"[1] -> "e"
    public subscript (index: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: index)
        return self[charIndex]
    }

    /// Subscript to get substring: "Hello"[1..3] -> "ell"
    public subscript (range: CountableRange<Int>) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = self.index(self.startIndex, offsetBy: range.count)

        return self[startIndex..<endIndex]
    }

    /// Method to tranform String representation of JSON to Any representation of JSON, thus String -> Any.
    ///
    /// - returns: JSON data within Any instance
    public func toJSONobject() -> Any {
        do {
            return try JSONSerialization.jsonObject(with: self.data(using: .utf8)!)
        } catch let JSONError {
            preconditionFailure("Parsing of devices failed with error: \(JSONError)")
        }
    }

    /// Method to tranform String -> Data.
    ///
    /// - returns: String within Data instance
    public func toData() -> Data? {
        if let dataValue = self.data(using: .utf8) {
            return dataValue
        }
        return nil
    }

    public func trunscated(width: CGFloat, fontAttributes: [String : Any]?) -> String {
        let string = self
        let nstext = string as NSString

        let ratio = nstext.size(attributes: fontAttributes).width/width

        if ratio <= 1 {
            return string
        } else {
            let stringLength = Int(CGFloat(nstext.length)/ratio) - 4

            let start = string.startIndex
            let end = string.index(start, offsetBy: stringLength)
            let range = start..<end
            let retString = string.substring(with: range)
            return "\(retString)..."
        }
    }

    /// Method to return an index of character if found in String instance.
    ///
    /// - returns: Position of character if found, nil otherwise.
    public func index(of char: Character) -> Int? {
        if let idx = characters.index(of: char) {
            return characters.distance(from: startIndex, to: idx)
        }
        return nil
    }
    
}
