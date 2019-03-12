//  UserCredentials.swift
//  QuantiBase
//
//  Created by Martin Troup on 19/01/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import Foundation

struct UserCredentials {
    let username: String
    let password: String
}

extension UserCredentials: CustomStringConvertible {
    var description: String {
        return "UserCredentials: {username: \(username), password: \(password)}"
    }
}
