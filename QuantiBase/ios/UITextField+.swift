//
//  UITextField+.swift
//  QuantiBase
//
//  Created by Martin Troup on 07/02/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//
#if canImport(UIKit)

import Foundation
import UIKit

extension UITextField {
	/// Get current cursor position within UITextField.
	public var currentCursorPosition: Int {
		guard let _selectedTextRange = selectedTextRange else {
			return 0
		}

		return offset(from: beginningOfDocument, to: _selectedTextRange.start)
	}

	/// Set cursor position to UITextField.
	///
	/// - Parameter index: of the position where cursor should be moved.
	public func setCursorPosition(to index: Int) {
		let position = self.position(from: beginningOfDocument, offset: index)

		guard let _position = position else { return }

		selectedTextRange = textRange(from: _position, to: _position)
	}

	/// Method to set bottom border for UITextField.
	///
	/// - Parameters:
	///   - color: of the bottom border
	///   - superviewColor: the text field's superview color (background color)
	public func setBottomBorder(colored color: UIColor, onSuperviewColor superviewColor: UIColor) {
		borderStyle = .none
		layer.backgroundColor = superviewColor.cgColor
		layer.masksToBounds = false
		layer.shadowColor = color.cgColor
		layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
		layer.shadowOpacity = 1.0
		layer.shadowRadius = 0.0
	}
}
#endif
