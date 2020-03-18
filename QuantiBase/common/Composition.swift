//
//  Composition.swift
//  QuantiBase
//
//  Created by Martin Troup on 23/07/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Overture

infix operator >>>: Composition
infix operator <<<: Composition

/// Forward composition of functions

public func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    pipe(f, g)
}

public func >>> <A, B, C>(f: @escaping (A) throws -> B, g: @escaping (B) throws -> C) -> (A) throws -> C {
    pipe(f, g)
}

/// Backward composition of functions

public func <<< <A, B, C>(g: @escaping (B) -> C, f: @escaping (A) -> B) -> (A) -> C {
    pipe(f, g)
}

public func <<< <A, B, C>(g: @escaping (B) throws -> C, f: @escaping (A) throws -> B) -> (A) throws -> C {
    pipe(f, g)
}
