//
//  RemoveOptionals.swift
//  2N-mobile-communicator
//
//  Created by David Nemec on 01/02/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import RxSwift

public protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

// Unfortunately the extra type annotations are required, otherwise the compiler gives an incomprehensible error.
extension Observable where Element: OptionalType {
    public func filterNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}
