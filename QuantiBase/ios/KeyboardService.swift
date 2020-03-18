//
//  KeyboardService.swift
//  ciggy-time
//
//  Created by Martin Troup on 04/02/2019.
//  Copyright © 2019 ciggytime.com. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

public typealias KeyboardFrame = CGRect
public typealias AnimationSpeed = Double

public class KeyboardService {
	public static let shared = KeyboardService()

    private let isKeyboardVisibleVariable = BehaviorRelay<Bool>(value: false)
	public var isKeyboardVisible: Bool {
		isKeyboardVisibleVariable.value
	}
	public var isKeyboardVisibleObservable: Observable<Bool> {
		isKeyboardVisibleVariable.asObservable()
	}

	private let _didRequestKeyboard = PublishSubject<Void>()
	public var didRequestKeyboard: Observable<Void> {
		_didRequestKeyboard.asObservable()
	}

	private let _keyboardWillShow = PublishSubject<(KeyboardFrame, AnimationSpeed)>()
	public var keyboardWillShow: Observable<(KeyboardFrame, AnimationSpeed)> {
		_keyboardWillShow.asObservable()
	}

	private let _keyboardDidShow = PublishSubject<Void>()
	public var keyboardDidShow: Observable<Void> {
		_keyboardDidShow.asObservable()
	}

	private let _keyboardWillHide = PublishSubject<(KeyboardFrame, AnimationSpeed)>()
	public var keyboardWillHide: Observable<(KeyboardFrame, AnimationSpeed)> {
		_keyboardWillHide.asObservable()
	}

	private let _keyboardDidHide = PublishSubject<Void>()
	public var keyboardDidHide: Observable<Void> {
		_keyboardDidHide.asObservable()
	}

	private let bag = DisposeBag()

	private init() {
		let center = NotificationCenter.default

		center.rx.notification(UIResponder.keyboardWillShowNotification)
			.map { notification in
				let userInfo = notification.userInfo!
				let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
				let animationSpeed = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0

				return (keyboardFrame, animationSpeed)
			}
			.bind(to: _keyboardWillShow)
			.disposed(by: bag)

		center.rx.notification(UIResponder.keyboardDidShowNotification)
			.map { _ in }
			.bind(to: _keyboardDidShow)
			.disposed(by: bag)

		center.rx.notification(UIResponder.keyboardWillHideNotification)
			.map { notification in
				let userInfo = notification.userInfo!
				let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
				let animationSpeed = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0

				return (keyboardFrame, animationSpeed)
			}
			.bind(to: _keyboardWillHide)
			.disposed(by: bag)

		center.rx.notification(UIResponder.keyboardDidHideNotification)
			.map { _ in }
			.bind(to: _keyboardDidHide)
			.disposed(by: bag)

		keyboardWillShow
			.map { _ in true }
			.bind(to: isKeyboardVisibleVariable)
			.disposed(by: bag)

		keyboardWillHide
			.map { _ in false }
			.bind(to: isKeyboardVisibleVariable)
			.disposed(by: bag)
	}

	public func becomeFirstResponder(on view: UIView) {
		view.becomeFirstResponder()

		_didRequestKeyboard.onNext(())
	}
}
