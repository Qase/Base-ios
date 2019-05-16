//
//  UILabel+copyrightSuperscripted.swift
//  QuantiBase
//
//  Created by Martin Troup on 07/02/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

extension UILabel {
	/// Method that goes through attributedText of a label (if available) and makes all occurences of Ⓡ superscripted.
	public func makeCopyrightSuperscripted() {
		guard let _attributedText = attributedText else { return }

		let newAttributedText = NSMutableAttributedString(attributedString: _attributedText)

		_attributedText.string.indices(ofSubstring: "Ⓡ").forEach { index in
			newAttributedText.addAttributes([NSAttributedString.Key.font: font.withSize(font.pointSize * (2/3)),
											 NSAttributedString.Key.baselineOffset: font.pointSize * (1/3)],
											range: NSRange(location: index, length: 1))
		}

		attributedText = newAttributedText
	}
}
