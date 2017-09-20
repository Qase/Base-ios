//
//  Collection+ReduceExtension.swift
//  QuantiBase
//
//  Created by Jakub Prusa on 26.08.17.
//  Copyright © 2017 David Nemec. All rights reserved.
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
