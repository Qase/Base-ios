//
//  EffectfulComposition.swift
//  QuantiBase
//
//  Created by Martin Troup on 23/07/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Overture

infix operator >=>: EffectfulComposition

/// Forward composition of functions that return optionals

public func >=> <A, B, C>(_ f: @escaping (A) -> B?, _ g: @escaping (B) -> C?) -> ((A) -> C?) {
    chain(f, g)
}

public func >=> <A, B, C>(_ f: @escaping (A) throws -> B?, _ g: @escaping (B) throws -> C?) -> ((A) throws -> C?) {
    chain(f, g)
}

/// Forward composition of functions that return arrays

public func >=> <A, B, C>(_ f: @escaping (A) -> [B], _ g: @escaping (B) -> [C]) -> ((A) -> [C]) {
    chain(f, g)
}

public func >=> <A, B, C>(_ f: @escaping (A) throws -> [B], _ g: @escaping (B) throws -> [C]) -> ((A) throws -> [C]) {
    chain(f, g)
}
