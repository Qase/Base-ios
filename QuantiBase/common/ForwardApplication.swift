//
//  ForwardApplication.swift
//  QuantiBase
//
//  Created by Martin Troup on 23/07/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Overture

infix operator |>: ForwardApplication

public func |> <A, B> (a: A, f: (A) throws -> B) rethrows -> B {
    return try with(a, f)
}
