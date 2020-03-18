//
//  SingleTypeComposition.swift
//  QuantiBase
//
//  Created by Martin Troup on 23/07/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Overture

infix operator <>: SingleTypeComposition

/// Forward composition of functions that take and return the same type

public func <> <A>(f: @escaping (A) -> A, g: @escaping (A) -> A) -> ((A) -> A) {
    concat(f, g)
}

public func <> <A>(f: @escaping (A) throws -> A, g: @escaping (A) throws -> A) -> ((A) throws -> A) {
    concat(f, g)
}

/// Concatenation of mutable functions that mutate the same type.

public func <> <A>(f: @escaping (inout A) -> Void, g: @escaping (inout A) -> Void) -> ((inout A) -> Void) {
    concat(f, g)
}

public func <> <A>(f: @escaping (inout A) throws -> Void, g: @escaping (inout A) throws -> Void) -> ((inout A) throws -> Void) {
    concat(f, g)
}

/// Concatenation of reference-mutable functions that mutate the same type.

public func <> <A: AnyObject>(_ f: @escaping (A) -> Void, _ g: @escaping (A) -> Void) -> (A) -> Void {
    concat(f, g)
}

public func <> <A: AnyObject>(_ f: @escaping (A) throws -> Void, _ g: @escaping (A) throws -> Void) -> (A) throws -> Void {
    concat(f, g)
}
