//
//  Notifying.swift
//  2N-push-notification-app
//
//  Created by Martin Troup on 19.09.16.
//  Copyright © 2016 Martin Troup. All rights reserved.
//

import UIKit

/// Notifying protocol should be implemented by every class that registeres some Notification observers. 
public protocol Notifying {
    func registerForNotifications()
}
