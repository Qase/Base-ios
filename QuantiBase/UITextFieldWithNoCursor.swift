//
//  UITextFieldWithNoCursor.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 16/03/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import UIKit

public class UITextFieldWithNoCursor: UITextField {
	override public func caretRect(for position: UITextPosition) -> CGRect {
		return CGRect.zero
	}
}
