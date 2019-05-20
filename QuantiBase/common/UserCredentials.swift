//  UserCredentials.swift
//  QuantiBase
//
//  Created by Martin Troup on 19/01/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import Foundation

public struct UserCredentials: Codable {
    public let username: String
    public let password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

extension UserCredentials: Equatable {}
