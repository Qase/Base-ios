//
//  DateExtension.swift
//  2N-mobile-communicator
//
//  Created by David Nemec on 08/11/2016.
//  Copyright © 2016 quanti. All rights reserved.
//

import Foundation

extension Date {
    public var dateTimeString: String {
        return toString(as: "dd MMMM, HH:mm")
    }


    public var timeString: String {
        return toString(as: "HH:mm:ss")
    }


    /// Method to convert Date -> String
    ///
    /// - Parameter format: Format of the Date instance to be represented in
    /// - Returns: String representation of Date instance in format set in parameter
    public func toString(`as` format: String = "yyyy-MM-dd hh:mm:ss:sss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.string(from: self)
    }
}
