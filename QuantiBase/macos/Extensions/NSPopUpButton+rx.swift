//
//  NSPopUpButton+rx.swift
//  QuantiBase macOS
//
//  Created by Martin Troup on 16/05/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//
#if os(macOS)
import Cocoa
import RxCocoa
import RxSwift

extension Reactive where Base: NSPopUpButton {

    /// Reactive wrapper for `selectedTag` property`.
    public var selectedTag: ControlProperty<Int> {
        self.base.rx.controlProperty(getter: { base in
            base.selectedTag()
        }, setter: { (base, state) in
            base.selectItem(withTag: state)
        })
    }

    /// Reactive wrapper for `selectedItem` property`.
    public var selectedItem: ControlProperty<NSMenuItem?> {
        self.base.rx.controlProperty(getter: { base -> NSMenuItem? in
            base.selectedItem
        }, setter: {base, item in
            base.select(item)
        })
    }
}
#endif
