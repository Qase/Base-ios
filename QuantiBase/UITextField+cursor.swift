//
//  UITextField+cursor.swift
//  QuantiBase
//
//  Created by Martin Troup on 07/02/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

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
}
