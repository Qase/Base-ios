//
//  Array+.swift
//  2N-push-notification-app
//
//  Created by Martin Troup on 06.10.16.
//  Copyright © 2016 Martin Troup. All rights reserved.
//

import Foundation

extension Array {
	// Remove first element of the collection that satisfies given condition.
	public mutating func removeFirst(where condition: (Element) -> Bool) {
		if let index = self.firstIndex(where: condition) {
			remove(at: index)
		}
	}

	/// Returns subarray containing objects on indices passed as parameter.
	///
	/// - Parameter indexSet: indices of objects to be returned
	/// - Returns: subarray of the original array
	public func objects(at indexSet: IndexSet) -> [Element] {
		indexSet.compactMap { self.indices.contains($0) ? self[$0] : nil }
	}

    /// Replaces element in array at specified index with another element.
    ///
    /// - Parameters:
    ///   - element: new element to replace the current one
    ///   - index: where the element to be replaced is
    /// - Returns: new array with replaced element
    public func replaced(element: Element, at index: Int) -> Array {
        self[0..<index].array + [element] + self[index+1..<count].array
    }

    /// Removes element at specified index.
    ///
    /// - Parameter index: where the element to be removed is
    /// - Returns: new array without deleted element
    public func removed(at index: Int) -> Array {
        self[0..<index].array + self[index+1..<count].array
    }
}

extension Array where Element: Equatable {
    // Remove first element of the collection that is equal to given `object`.
    public mutating func removeFirst(object: Element) {
		removeFirst { $0 == object }
    }
}
