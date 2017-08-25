//
//  MultipleDelegating.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 22.12.16.
//  Copyright © 2016 quanti. All rights reserved.
//

import Foundation

public protocol BasicDelegate: class {}

public class WeakDelegate {
    weak var delegate: BasicDelegate?

    init (_ delegate: BasicDelegate) {
        self.delegate = delegate
    }
}

public protocol MultipleDelegating: class {
    associatedtype GenericDelegateType

    var delegates: [String: WeakDelegate] { get set }
}

extension MultipleDelegating {
    /// Method to allocate array of delegates.
    public func initDelegates() {
        delegates = [String: WeakDelegate]()
    }

    /// Method to add delegate of Connectivity Manager.
    ///
    /// - Parameter delegate: delegate to be added
    public func add(delegate: BasicDelegate, forKey key: String) {
        delegates[key] = WeakDelegate(delegate)
    }

    /// Method to remove delegate of Connectivity Manager.
    ///
    /// - Parameter delegate: delegate to be removed
    public func removeDelegate(byKey key: String) {
        delegates.removeValue(forKey: key)
    }

    /// Method to return array of delegates without its weak wrapping.
    ///
    /// - Returns: array of delegates of specified type
    public func getUnwrappedDelegates() -> [GenericDelegateType] {

        // map returns [GenericDelegateType?] and flatMap returns [GenericDelegateType], therefore filters those items in array that are nil
        return delegates.map { $0.value.delegate as? GenericDelegateType }.flatMap { $0 }

//        return delegates
//            .filter({ (_, weakDelegate) -> Bool in
//                if let _delegate = weakDelegate.delegate, (_delegate as? GenericDelegateType) != nil {
//                    return true
//                }
//                print("MultipleDelegating protocol problem - delegate within weak wrapping class does not exist or it cannot be cast to GenericDelegateType")
//                return false
//            }).map { (_, weakDelegate) -> GenericDelegateType in
//                // swiftlint:disable:next force_cast
//                return weakDelegate.delegate! as! GenericDelegateType
//            }
    }
}
