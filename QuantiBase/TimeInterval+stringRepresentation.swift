//
//  TimeInterval+stringRepresentation.swift
//  2N-mobile-communicator
//
//  Created by Jakub Prusa on 24.11.16.
//  Copyright © 2016 quanti. All rights reserved.
//

import Foundation

extension Double {
    /// Format NSTimeInterval to nice format.
    /// Custom function which is similar to NSDateFormatter
    /// Default format is hh:mm:ss:sss
    ///
    /// - Parameter format: desired format
    /// - Returns: format NSTimeInterval as String
    public func format(_ format: String = "hh:mm:ss:sss") -> String {
        let ms      = Int(self.truncatingRemainder(dividingBy: 1.0) * 1000)
        let asInt   = NSInteger(self)
        let s       = asInt % 60
        let m       = (asInt / 60) % 60
        let h       = (asInt / 3600)

        var value   = format
        value       = value.replace("hh", replacement: String(format: "%0.2d", h))
        value       = value.replace("mm", replacement: String(format: "%0.2d", m))
        value       = value.replace("sss", replacement: String(format: "%0.3d", ms))
        value       = value.replace("ss", replacement: String(format: "%0.2d", s))
        return value
    }
}
