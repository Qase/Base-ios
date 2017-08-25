//
//  GlobalFunctions.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 12.12.16.
//  Copyright © 2016 quanti. All rights reserved.
//

import Foundation

public func isSimulator() -> Bool {
    return TARGET_OS_SIMULATOR != 0
}
