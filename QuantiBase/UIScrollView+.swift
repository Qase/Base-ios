//
//  UIScrollView+.swift
//  QuantiBase
//
//  Created by Martin Troup on 07/02/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

extension UIScrollView {

	/// Detects if it is scrolled over the contentSize of the scrollView (over bounds).
	/// - sometimes the scrollView is made to scroll even lower than its contentSize bottom
	public var scrolledOverBottomLine: Bool {
		self.setNeedsLayout()
		self.layoutIfNeeded()

		return contentOffset.y > (contentSize.height - bounds.size.height + contentInset.bottom)
	}

	/// Scroll to the bottom of a view specified within a parameter.
	///
	/// - Parameters:
	///   - view: to scroll to, if nil -> scroll to the bottom of the screen
	///   - animated: if the scrolling should be animated
	public func scrollToBottom(of view: UIView? = nil, animated: Bool = true) {
		self.setNeedsLayout()
		self.layoutIfNeeded()

		let areaHeight = view != nil ? view!.bounds.height : UIScreen.main.bounds.height
		let bottomOffset = contentSize.height <= areaHeight
			? CGPoint(x: 0, y: -contentInset.top)
			: CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
		setContentOffset(bottomOffset, animated: animated)
	}


	/// Scroll to the top of a view specified within a parameter.
	///
	/// - Parameters:
	///   - view: to scroll to, if nil -> scroll to the top of the screen
	///   - topOffset: top offset, in case the user does not want to scroll directly to the top but keep some offset
	///   - animated: if the scrolling should be animated
	public func scrollToTop(of view: UIView? = nil, withTopOfsset topOffset: CGFloat = 0, animated: Bool = true) {
		self.setNeedsLayout()
		self.layoutIfNeeded()

		guard let _view = view else {
			let top = CGPoint(x: 0, y: -topOffset)
			setContentOffset(top, animated: animated)

			return
		}

		let viewTop = CGPoint(x: _view.frame.origin.x, y: _view.frame.origin.y - topOffset)
		setContentOffset(viewTop, animated: animated)
	}
}
