//
//  Dictionary+.swift
//  QuantiBase
//
//  Created by Martin Troup on 22/05/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

extension Dictionary {
    /// Returns key-value tuple on given index.
    ///
    /// - Parameter i: index
    subscript(i: Int) -> (key: Key, value: Value) {
        self[index(startIndex, offsetBy: i)]
    }
}
