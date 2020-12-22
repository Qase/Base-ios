//
//  NSMenu+.swift
//  QuantiBase macOS
//
//  Created by Martin Troup on 16/05/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//
#if os(macOS)

import Cocoa

extension NSMenu {
    public func performActionForItem(withTag: Int) {
        performActionForItem(at: indexOfItem(withTag: withTag))
    }
}
#endif
