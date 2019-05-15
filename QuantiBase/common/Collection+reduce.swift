//
//  Collection+reduce.swift
//  QuantiBase
//
//  Created by Jakub Prusa on 26.08.17.
//  Copyright © 2017 David Nemec. All rights reserved.
//

import Foundation

extension Collection {
    /// Method that is an extension to native reduce functional method. It allows to access the array size within its callback scope and thus
    /// it can be used for such reductions as average is.
    public func reduce<U>(_ seed: U, combiner: (Int, U, Iterator.Element) -> U) -> U {
        var current = seed
        for item in self {
            current = combiner(Int(count), current, item)
        }
        return current
    }
}
