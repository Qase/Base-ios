//
//  Environment.swift
//  QuantiBase
//
//  Created by David Nemec on 20.04.2021.
//  Copyright © 2021 David Nemec. All rights reserved.
//

import Foundation

public class VoidPrintLogger: Logging {
    public func log(_ message: String, onLevel level: LoggingLevel, inFile file: String, inFunction function: String, onLine line: Int) {
    }


}


public struct QuantiBaseEnvironment {
    public var logger: Logging = VoidPrintLogger() {
        didSet { logger.log("Added logger to QuantiLogger", onLevel: .debug) }
    }
}


public final class QuantiBaseEnv {
    /// Container with dependencies
    public static var current: QuantiBaseEnvironment = QuantiBaseEnvironment()
}
