//
//  UITextFieldWithNoCursor.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 16/03/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import UIKit

open class UITextFieldWithNoCursor: UITextField {
	override open func caretRect(for position: UITextPosition) -> CGRect {
		CGRect.zero
	}
}
