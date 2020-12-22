//
//  UIToolbarForPicker.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 16/03/2018.
//  Copyright © 2018 quanti. All rights reserved.
//
#if canImport(UIKit)

import UIKit

open class UIToolbarForPicker: UIToolbar {
	public var leftButton: UIBarButtonItem? {
		didSet {
			reassignButtons()
		}
	}

	public var rightButton: UIBarButtonItem? {
		didSet {
			reassignButtons()
		}
	}

	private let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

	override init(frame: CGRect) {
		super.init(frame: frame)

		barStyle = .default
		isTranslucent = true
		tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
		sizeToFit()
		isUserInteractionEnabled = true

		reassignButtons()
	}

	private func reassignButtons() {
		let newButtons = [leftButton, spaceButton, rightButton].compactMap { $0 }
		setItems(newButtons, animated: false)
	}

	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
#endif
