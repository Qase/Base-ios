//
//  String+.swift
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

    /// Subscript to get substring: "Hello"[1..<4] -> "ell"
    public subscript (range: CountableRange<Int>) -> String? {
        guard range.lowerBound < range.upperBound else { return nil }
        guard range.lowerBound >= 0 else { return nil }
        guard range.lowerBound < self.count, range.upperBound <= self.count else { return nil }

        return range.sorted { $0 < $1 }
                    .map { self[$0] }
                    .reduce("") { String($0) + String($1) }
    }

    /// Method to tranform String representation of JSON to Any representation of JSON, thus String -> Any.
    ///
    /// - returns: JSON data within Any instance
    public var json: Any {
        do {
            return try JSONSerialization.jsonObject(with: self.data(using: .utf8)!)
        } catch let JSONError {
            preconditionFailure("Parsing of devices failed with error: \(JSONError)")
        }
    }

    /// Method to tranform String -> Data.
    ///
    /// - returns: String within Data instance
    public var data: Data? {
        return self.data(using: .utf8)
    }

	/// Method to get String.Index instance from Int.
	///
	/// - Parameter intIndex: index value represented as Int.
	/// - Returns: index value represented as String.Index.
	public func index(at intIndex: Int) -> String.Index {
		return index(self.startIndex, offsetBy: intIndex)
	}

	/// Method to return a number of occurences of given substring within the string.
	///
	/// - Parameter substring: to be found
	/// - Returns: number of substring's occurences
	public func numberOfOcurrences(ofSubstring substring: String) -> Int {
		return indices(ofSubstring: substring).count
	}

    /// Method to return an index of character if found in String instance.
    ///
    /// - returns: Position of character if found, nil otherwise.
    public func firstIndex(of char: Character) -> Int? {
		return indices(ofSubstring: String(char)).first
    }

	/// Method to return an array of indices of all occurences of given substring.
	///
	/// - Parameter string: substring to be found
	/// - Returns: array of indices of all substring occurences.
	public func indices(ofSubstring substring: String) -> [Int] {
		var indices = [Int]()
		var searchStartIndex = self.startIndex

		while searchStartIndex < self.endIndex,
			let range = self.range(of: substring, range: searchStartIndex..<self.endIndex),
			!range.isEmpty {
				let index = distance(from: self.startIndex, to: range.lowerBound)
				indices.append(index)
				searchStartIndex = range.upperBound
		}

		return indices
	}

	/// Method to convert String instance to Date with custom date time format.
	///
	/// - Parameter format: format of Date
	/// - Returns: Date instance
	public func asDate(withFormat format: String = "yyyy-MM-dd hh:mm:ss:sss") -> Date? {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		//formatter.locale = Locale(identifier: "en_US")

		return formatter.date(from: self)
	}

	/// Check if string contains only numbers. This function work also for number greater then 2^32 because doesn't use Int casting
	///
	/// - Returns: true if contains only number
	public var isNumeric: Bool {
		if !self.isEmpty {
			let numberCharacters = CharacterSet.decimalDigits.inverted

			return self.rangeOfCharacter(from: numberCharacters) == nil
		}

		return false
	}

    /// First letter of the string gets Capitalized.
    /// Note:
    ///     - "hello world".capitalized = "Hello World"
    ///     - "hello world".firstLetterCapitalized = "Hello world"
    var firstLetterCapitalized: String {
        return prefix(1).uppercased() + self.dropFirst()
    }

    /// Wrapper around NSLocalizedString(_:comment)
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}
