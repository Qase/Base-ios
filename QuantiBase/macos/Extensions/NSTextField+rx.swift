//
//  NSTextField+rx.swift
//  QuantiBase macOS
//
//  Created by Martin Troup on 16/05/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//
#if os(macOS)

import Cocoa
import RxCocoa
import RxSwift

extension Reactive where Base: NSTextField {

    /// Reactive wrapper for `textColor` property`.
    public var textColor: ControlProperty<NSColor?> {
        self.base.rx.controlProperty(getter: { (base) in
            base.textColor
        }, setter: { (base, color) in
            base.textColor = color
        })
    }

    /// Reactive wrapper for `delegate` message.
    public var didBeginEditing: ControlEvent<()> {
        ControlEvent<()>(events: self.delegate
            .methodInvoked(#selector(NSTextFieldDelegate.controlTextDidBeginEditing(_:)))
            .map { _ in ()})
    }

    /// Reactive wrapper for `delegate` message.
    public var didEndEditing: ControlEvent<()> {
        ControlEvent<()>(events: self.delegate
            .methodInvoked(#selector(NSTextFieldDelegate.controlTextDidEndEditing(_:)))
            .map { _ in ()})
    }

}
#endif
