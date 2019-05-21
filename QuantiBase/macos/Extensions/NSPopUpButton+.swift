//
//  NSPopUpButton+.swift
//  QuantiBase
//
//  Created by Martin Troup on 16/05/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Cocoa

extension NSPopUpButton {
    public func itemTitle(withTag: Int) -> String {
        return itemTitles[indexOfItem(withTag: withTag)]
    }
}
