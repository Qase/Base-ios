//
//  SystemLogger.swift
//  QuantiBase
//
//  Created by George Ivannikov on 10/8/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//

import Foundation
import os.log

extension OSLog {
    static let bleframework = OSLog(subsystem: "com.quanti.mobile.qbase", category: "qbase")
}

extension LoggingLevel {
    fileprivate var os_level: OSLogType {
        switch self {
        case .debug:
            return .debug
        case .info:
            return .info
        case .error, .warn, .verbose:
            return .default
        case .process:
            return .error
        case .system:
            return .fault
        }
    }
}

public struct SystemLogger: Logging {
    
    private let levels: [LoggingLevel]

    init(onLevels levels: [LoggingLevel] = LoggingLevel.allCases) {
        self.levels = levels
    }

    public func log(_ message: String,
                    onLevel level: LoggingLevel,
                    inFile file: String,
                    inFunction function: String,
                    onLine line: Int) {
        guard levels.contains(level) else { return }
        let filename = URL(string: file)?.lastPathComponent ?? ""
        let levelUppercased = "\(level)".uppercased()
        let staticMessage = "[\(levelUppercased)] \(filename) - \(function) - line \(line): \(message)"

        os_log("%@", log: OSLog.bleframework, type: level.os_level, staticMessage)
    }
}

extension SystemLogger {
    public static var allLevels: SystemLogger {
        SystemLogger(onLevels: LoggingLevel.allCases)
    }

    public static var shallow: SystemLogger {
        SystemLogger(onLevels: [.error, .warn, .info, .debug])
    }

    public static var `default`: SystemLogger {
        SystemLogger(onLevels: [.error, .warn, .info, .debug, .verbose])
    }
}
