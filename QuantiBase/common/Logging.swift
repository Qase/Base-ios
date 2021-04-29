//
//  Logging.swift
//  QuantiBase
//
//  Created by VS on 19.11.2020.
//  Copyright © 2020 David Nemec. All rights reserved.
//

public enum LoggingLevel: CaseIterable {
    case error
    case warn
    case info
    case debug
    case verbose
    case process
    case system
}

public protocol Logging {
    func log(_ message: String,
             onLevel level: LoggingLevel,
             inFile file: String,
             inFunction function: String,
             onLine line: Int)
}

extension Logging {
    public func log(_ message: String,
                    onLevel level: LoggingLevel,
                    inFile file: String = #file,
                    inFunction function: String = #function,
                    onLine line: Int = #line) {
        log(message, onLevel: level, inFile: file, inFunction: function, onLine: line)
    }
}
