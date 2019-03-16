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

    public init(username: String = "", password: String = "") {
        self.username = username
        self.password = password
    }
}

extension UserCredentials: CustomStringConvertible {
    public var description: String {
        return "UserCredentials: {username: \(username), password: \(password)}"
    }
}

extension UserCredentials: Equatable {
    public static func == (lhs: UserCredentials, rhs: UserCredentials) -> Bool {
        return lhs.username == rhs.username && lhs.password == rhs.password
    }
}
