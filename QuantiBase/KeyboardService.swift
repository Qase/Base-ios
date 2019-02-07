//
//  KeyboardService.swift
//  QuantiBase
//
//  Created by Martin Troup on 07/02/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import UIKit

public typealias KeyboardFrame = CGRect
public typealias AnimationSpeed = Double

public protocol KeyboardServiceDelegate: class {
	func didRequestKeyboard()
	func keyboardWillShow(frame: KeyboardFrame, animationSpeed: AnimationSpeed)
	func keyboardDidShow()
	func keyboardWillHide(frame: KeyboardFrame, animationSpeed: AnimationSpeed)
	func keyboardDidHide()
}

public class KeyboardService: MultipleDelegating {
	public static let shared = KeyboardService()

	public typealias GenericDelegateType = KeyboardServiceDelegate
	public var delegates = [String : WeakDelegate]()

	private(set) var isKeyboardVisible: Bool = false

	private init() {
		registerForNotifications()
	}

	func becomeFirstResponder(on view: UIView) {
		view.becomeFirstResponder()

		unwrappedDelegates.forEach { $0.didRequestKeyboard() }
	}
}

extension KeyboardService: Notified {
	public func registerForNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)

		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
	}

	@objc private func keyboardWillShow(notification: Notification) {
		guard let userInfo = notification.userInfo else {
			print("\(#function) - notification's userInfo is nil.")
			return
		}

		let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
		let animationSpeed = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0

		unwrappedDelegates.forEach { $0.keyboardWillShow(frame: keyboardFrame, animationSpeed: animationSpeed) }
	}

	@objc private func keyboardDidShow(notification: Notification) {
		unwrappedDelegates.forEach { $0.keyboardDidShow() }
		isKeyboardVisible = true
	}

	@objc private func keyboardWillHide(notification: Notification) {
		guard let userInfo = notification.userInfo else {
			print("\(#function) - notification's userInfo is nil.")
			return
		}

		let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
		let animationSpeed = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0

		unwrappedDelegates.forEach { $0.keyboardWillHide(frame: keyboardFrame, animationSpeed: animationSpeed) }
	}

	@objc private func keyboardDidHide(notification: Notification) {
		unwrappedDelegates.forEach { $0.keyboardDidShow() }
		isKeyboardVisible = false
	}
}

