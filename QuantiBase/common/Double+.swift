//
//  Double+.swift
//  QuantiBase
//
//  Created by Martin Troup on 22/05/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

public extension Double {
    /// Rounds the double to decimal places value

    /// Returns String representation of self
    ///
    /// - Parameter places: number of places to be rounded to
    /// - Returns: String representation of self
    func string(roundedToPlaces places: Int) -> String {
        String(format: "%.\(places)f", self)
    }
}
