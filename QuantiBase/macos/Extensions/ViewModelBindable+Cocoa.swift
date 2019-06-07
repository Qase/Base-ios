//
//  ViewModelBindable+Cocoa.swift
//  QuantiBase macOS
//
//  Created by Martin Troup on 16/05/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Cocoa

extension ViewModelBindable where Self: NSWindowController {
    public static func instantiate<ViewModelType> (with viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
        var viewController = Self()
        viewController.viewModel = viewModel
        return viewController
    }
}

extension ViewModelBindable where Self: NSViewController {
    static func instantiate<ViewModelType>(with viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
        var viewController = Self()
        viewController.viewModel = viewModel

        return viewController
    }
}
