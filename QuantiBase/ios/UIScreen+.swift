//
//  UIScreen+.swift
//  ciggy-time
//
//  Created by Martin Troup on 03/06/2018.
//  Copyright © 2018 ciggytime.com. All rights reserved.
//
#if canImport(UIKit)

import UIKit

extension UIScreen {
	public static var isHorizontalCompact: Bool {
		UIScreen.main.traitCollection.horizontalSizeClass == .compact
	}

	public static var isHorizontalRegular: Bool {
		UIScreen.main.traitCollection.horizontalSizeClass == .regular
	}

	public static var isVerticalCompact: Bool {
		UIScreen.main.traitCollection.verticalSizeClass == .compact
	}

	public static var isVerticalRegular: Bool {
		UIScreen.main.traitCollection.verticalSizeClass == .regular
	}
}
#endif
