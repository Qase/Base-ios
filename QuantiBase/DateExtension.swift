//
//  DateExtension.swift
//  2N-mobile-communicator
//
//  Created by David Nemec on 08/11/2016.
//  Copyright © 2016 quanti. All rights reserved.
//

import Foundation

extension NSDate {

    /// Method to transform Data -> String in Hex representation.
    ///
    /// - returns: String in Hex representation
    public func customFormatedAsString() -> String {
        let formatter = DateFormatter()

        //formater.dateFormat = ""
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter.string(from: self as Date)
    }

    public func customFormatedAsStringDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, HH:mm"

        return formatter.string(from: self as Date)
    }

    public func customFormatedAsStringTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"

        return formatter.string(from: self as Date)
    }
}
