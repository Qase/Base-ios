//
//  UIBarButtonItem+activityViewController.swift
//  QuantiBase
//
//  Created by Martin Troup on 07/02/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import Foundation

extension UIBarButtonItem {
	/// Binds given activityViewController to the bar button item.
	///
	/// - Parameter activityViewController: to be binded to the bar button item
	public func assign(_ activityViewController: UIActivityViewController) {
		guard let targetView = self.value(forKey: "view") as? UIView else {
			print("\(#function) - cannot cast UIBarButtonItem to View while trying to set it as a targetView for UIActivityViewController.")
			return
		}

		activityViewController.popoverPresentationController?.sourceView = targetView
		activityViewController.popoverPresentationController?.sourceRect = targetView.bounds
	}
}
