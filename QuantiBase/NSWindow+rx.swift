//
//  NSWindow+rx.swift
//  QuantiBase macOS
//
//  Created by Martin Troup on 16/05/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Cocoa
import RxCocoa
import RxSwift

extension Reactive where Base: NSWindow {

    /// Bindable sink for `title` property`.
    public var title: Binder<String> {
        return Binder(self.base) { base, value in
            base.title = value
        }
    }

    /// Bindable sink for `level` property`.
    public var level: Binder<NSWindow.Level> {
        return Binder(self.base) { base, value in
            base.level = value
        }
    }
}
