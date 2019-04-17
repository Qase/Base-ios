//  UserCredentials.swift
//  QuantiBase
//
//  Created by Martin Troup on 19/01/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import Foundation

public struct UserCredentials {
    public let username: String
    public let password: String
}

extension UserCredentials: CustomStringConvertible {
    public var description: String {
        return "UserCredentials: {username: \(username), password: \(password)}"
    }
}
