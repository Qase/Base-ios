//
//  ViewModelBindable+UIKit.swift
//  QuantiBase
//
//  Created by Martin Troup on 16/05/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//
#if canImport(UIKit)

import UIKit

extension ViewModelBindable where Self: UIViewController {
    public static func instantiate<ViewModelType> (withViewModel viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
        var viewController = Self()
        viewController.viewModel = viewModel
        return viewController
    }
}
#endif
