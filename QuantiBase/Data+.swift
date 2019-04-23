//
//  Data+.swift
//  QuantiBase
//
//  Created by Martin Troup on 23/04/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

public extension Data {
    /// Method to tranform Data -> String.
    ///
    /// - returns: Data within String instance
    var string: String? {
        return String(data: self, encoding: .utf8)
    }
}
