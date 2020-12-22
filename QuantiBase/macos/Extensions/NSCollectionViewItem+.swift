//
//  NSCollectionViewItem+.swift
//  QuantiBase macOS
//
//  Created by Martin Troup on 16/05/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

#if os(macOS)

import Cocoa

extension NSCollectionViewItem {
    public static var userInterfaceItemIdentifier: NSUserInterfaceItemIdentifier {
        NSUserInterfaceItemIdentifier(String(describing: self))
    }
}
#endif
