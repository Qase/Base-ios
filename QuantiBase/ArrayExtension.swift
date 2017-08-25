//
//  ArrayExtension.swift
//  2N-push-notification-app
//
//  Created by Martin Troup on 06.10.16.
//  Copyright © 2016 Martin Troup. All rights reserved.
//

import Foundation

/*
!! NOTE: - do not delete the extension, it is not used but servers as an example how to restrict extension for a specific class !!
 
extension Collection where Iterator.Element == Confirmation {
    func reduceToAverageConfirmationTime() -> Double {
        return reduce(0.0, { (result, confirmation) -> Double in
            result + (Double(confirmation.confirmationTime!) / Double(count.toIntMax()))
        })
    }
}
*/

extension Collection {

    /// Method that is an extension to native reduce functional method. It allows to access the array size within its callback scope and thus
    /// it can be used for such reductions as average is.
    public func reduce<U>(seed: U, combiner: (Int, U, Iterator.Element) -> U) -> U {
        var current = seed
        for item in self {
            current = combiner(Int(count.toIntMax()), current, item)
        }
        return current
    }
}

extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    public mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
