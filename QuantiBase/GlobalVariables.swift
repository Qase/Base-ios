//
//  GlobalFunctions.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 12.12.16.
//  Copyright © 2016 quanti. All rights reserved.
//

import Foundation

public var isSimulator: Bool {
    return TARGET_OS_SIMULATOR != 0
}

public var isiPhone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}

public var isiPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}
