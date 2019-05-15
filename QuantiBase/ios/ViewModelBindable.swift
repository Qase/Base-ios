//
//  ViewModelBindable.swift
//  ciggy-time
//
//  Created by Martin Troup on 17/04/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//

import UIKit

/// Protocol that should be implemented by a class or struct that is in charge of binding a viewModel.
public protocol ViewModelBindable {
	associatedtype ViewModelType

	var viewModel: ViewModelType { get set }
}

extension ViewModelBindable where Self: UIViewController {
	public static func instantiate<ViewModelType> (withViewModel viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
		var viewController = Self()
		viewController.viewModel = viewModel
		return viewController
	}
}
