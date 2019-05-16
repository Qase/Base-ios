//
//  ViewModelBindable.swift
//  ciggy-time
//
//  Created by Martin Troup on 17/04/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//

import Foundation

/// Protocol that should be implemented by a class or struct that is in charge of binding a viewModel.
public protocol ViewModelBindable {
	associatedtype ViewModelType

	var viewModel: ViewModelType { get set }
}


