//
//  UINavigationItem+reactive.swift
//  QuantiBase
//
//  Created by Dagy Tran on 05/11/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UINavigationItem {

    public var title: Binder<String?> {
        Binder(self.base) { base, title in
            base.title = title
        }
    }

    public var leftBarButtonItem: Binder<UIBarButtonItem?> {
        Binder(self.base) { base, buttonItem in
            base.leftBarButtonItem = buttonItem
        }
    }

    public var rightBarButtonItem: Binder<UIBarButtonItem?> {
        Binder(self.base) { base, buttonItem in
            base.rightBarButtonItem = buttonItem
        }
    }

    public var leftBarButtonItems: Binder<[UIBarButtonItem]?> {
        Binder(self.base) { base, buttonItems in
            base.leftBarButtonItems = buttonItems
        }
    }

    public var rightBarButtonItems: Binder<[UIBarButtonItem]?> {
        Binder(self.base) { base, buttonItems in
            base.rightBarButtonItems = buttonItems
        }
    }
}
