//
//  UINavigationController+reactive.swift
//  QuantiBase
//
//  Created by Dagy Tran on 05/11/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    public var toolbarItems: Binder<[UIBarButtonItem]?> {
        Binder(self.base) { base, buttonItems in
            base.toolbarItems = buttonItems
        }
    }
}
