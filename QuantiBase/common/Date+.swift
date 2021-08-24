//
//  Date+.swift
//  2N-mobile-communicator
//
//  Created by David Nemec on 08/11/2016.
//  Copyright © 2016 quanti. All rights reserved.
//

import Foundation

extension Date {
    public var dateTimeString: String {
        asString("dd MMMM, HH:mm")
    }

    public var timeString: String {
        asString("HH:mm:ss")
    }

    /// Method to convert Date -> String
    ///
    /// - Parameter format: Format of the Date instance to be represented in
    /// - Returns: String representation of Date instance in format set in parameter
    public func asString(_ format: String = "dd-MM-yyyy HH:mm:ss,SSS") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.string(from: self)
    }
}
