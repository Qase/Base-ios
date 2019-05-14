//
//  UITextViewWithZeroPadding.swift
//  2NLock
//
//  Created by Martin Troup on 14/03/2019.
//  Copyright © 2019 Quanti. All rights reserved.
//

import UIKit

open class UITextViewWithZeroPadding: UITextView {
	override open func layoutSubviews() {
		super.layoutSubviews()

		textContainerInset = UIEdgeInsets.zero
		textContainer.lineFragmentPadding = 0
	}
}
