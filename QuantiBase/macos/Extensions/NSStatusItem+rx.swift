//
//  NSStatusItem+rx.swift
//  QuantiBase macOS
//
//  Created by Martin Troup on 07/06/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//
#if os(macOS)
import Cocoa
import RxSwift
import RxCocoa

extension Reactive where Base: NSStatusItem {
    public var menu: Binder<NSMenu> {
        Binder(self.base) { $0.menu = $1 }
    }
}
#endif
