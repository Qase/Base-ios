//
//  InterfaceIdiom.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 11.01.17.
//  Copyright © 2017 quanti. All rights reserved.
//

import Foundation

public func isiPhone() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}

public func isiPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}
