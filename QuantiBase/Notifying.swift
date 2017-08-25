//
//  Notifying.swift
//  2N-push-notification-app
//
//  Created by Martin Troup on 19.09.16.
//  Copyright © 2016 Martin Troup. All rights reserved.
//

import UIKit

/// Notifying protocol should be implemented by every class that registeres some Notification observers. 
/// removeNotifications() method of the protocol should be called within deinit() method of the class that implements the protocol so 
/// all registered observers are removed before the instance is released which prevents from memory leaks.
public protocol Notifying {
    func registerForNotifications()
    func removeNotifications()
}

extension Notifying {
    public func removeNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}
