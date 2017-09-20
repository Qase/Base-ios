//
//  ArrayExtension.swift
//  2N-push-notification-app
//
//  Created by Martin Troup on 06.10.16.
//  Copyright © 2016 Martin Troup. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    public mutating func removeFirst(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
