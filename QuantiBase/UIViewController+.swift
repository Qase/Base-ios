//
//  UIViewController+.swift
//  QuantiBase
//
//  Created by David Nemec on 17/08/2017.
//  Copyright © 2017 David Nemec. All rights reserved.
//

extension UIViewController {
    /// Disable / enable tabBar if present
    ///
    /// - Parameter isEnabled: indication if the tabBar should be enabled / disabled
    public func enableTabBar(_ isEnabled: Bool) {
        if let _tabBarItems = tabBarController?.tabBar.items {
			_tabBarItems.forEach { $0.isEnabled = isEnabled }
        }
    }

	/// Returns the actualViewController - if it is wrapped within a navigationViewController.
	public var actualViewController: UIViewController {
		if let navigationViewController = self as? UINavigationController {
			return navigationViewController.viewControllers.first ?? self
		} else {
			return self
		}
	}

	/// Add a child viewController to the viewController.
	///
	/// - Parameters:
	///   - childViewController: a viewController to be added
	///   - view: a view where the new childViewController's view should be added as subview, should be self.view by default
	public func add(childViewController: UIViewController, andDisplayIn view: UIView) {
		addChild(childViewController)
		if let _stackView = view as? UIStackView {
			_stackView.addArrangedSubview(childViewController.view)
		} else {
			view.addSubview(childViewController.view)
		}
		childViewController.didMove(toParent: self)
	}

	/// Method remove the viewController from its parent viewController.
	public func completelyRemoveFromParent() {
		willMove(toParent: nil)
		view.removeFromSuperview()
		removeFromParent()
	}

	/// Method to remove all childViewControllers from THE viewController.
	public func removeAllChildViewControllers() {
		removeAllChildViewControllers(from: self)
	}

	private func removeAllChildViewControllers(from viewController: UIViewController) {
		viewController.children.forEach { childViewController in
			removeAllChildViewControllers(from: childViewController)
			childViewController.removeFromParent()
		}
	}

	/// Method to present an instance of UIAlertController on the instance of UIViewController. Such UIAlerController does not contain any actions
	/// and is being shown only for a limited period of time.
	///
	/// - Parameters:
	///   - title: of the UIAlertController
	///   - subtitle: of the UIAlertController
	///   - timeInterval: how long the UIAlertController is being presented
	///   - animated: if should be presented in animation
	///   - onCompleted: closure being called after the UIAlertController is presented and hidden again
	public func presentTemporaryAlertController(withTitle title: String, andSubtitle subtitle: String? = nil, forTime timeInterval: TimeInterval = 1.0, animated: Bool = true, onCompleted: (() -> Void)? = nil) {
		let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
		self.present(alertController, animated: animated) {
			DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval, execute: {
				alertController.dismiss(animated: animated) {
					onCompleted?()
				}
			})
		}
	}
    
    /// Computed property that returns the controller wrapped in a UINavigationController instance, thus it returns UINavigationController.
    public var wrappedInNavigationController: UINavigationController {
        return UINavigationController(rootViewController: self)
    }

}
