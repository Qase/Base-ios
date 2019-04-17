//
//  ActivityIndicatorView.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 24/04/2018.
//  Copyright © 2018 quanti. All rights reserved.
//

import UIKit
import RxSwift

public enum AppearanceStatus {
	case shown
	case hidden
}

open class CustomActivityIndicatorView: UIView {
	public let size: CGFloat = 100.0
	public let appearanceAnimation: TimeInterval = 0.3

	private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)//UIActivityIndicatorView(style: .whiteLarge)

	private let _appearanceDidChange = PublishSubject<AppearanceStatus>()
	public var appearanceDidChange: Observable<AppearanceStatus> {
		return _appearanceDidChange.asObservable()
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = UIColor.black.withAlphaComponent(0.7)
		clipsToBounds = true
		layer.cornerRadius = 8.0
		alpha = 0

		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: size).isActive = true
		widthAnchor.constraint(equalToConstant: size).isActive = true

		addSubview(activityIndicator)

		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
	}

	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func changeAppearance(to newState: AppearanceStatus, animated: Bool) {
		UIView.animate(withDuration: animated ? appearanceAnimation : 0.0, animations: {
			switch newState {
			case .shown:
				self.activityIndicator.startAnimating()
				self.alpha = 1
			case .hidden:
				self.activityIndicator.stopAnimating()
				self.alpha = 0
			}

		}, completion: { _ in
			switch newState {
			case .shown:
				self._appearanceDidChange.onNext(.shown)
			case .hidden:
				self._appearanceDidChange.onNext(.hidden)
			}
		})
	}

	public func show(animated: Bool = true) {
		guard alpha == 0 else {
			print("\(#function) - customActivityIndicatorView is already shown.")
			return
		}

		changeAppearance(to: .shown, animated: animated)
	}

	public func hide(animated: Bool = true) {
		guard alpha == 1 else {
			print("\(#function) - customActivityIndicatorView is already hidden.")
			return
		}

		changeAppearance(to: .hidden, animated: animated)
	}
}
