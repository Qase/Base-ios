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
	/// Delegates without its weak wrapping.
	public var unwrappedDelegates: [GenericDelegateType] {
		return delegates.map { $0.value.delegate as? GenericDelegateType }.compactMap { $0 }
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
}
