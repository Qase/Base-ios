//
//  UIViewControllerExtension.swift
//  QuantiBase
//
//  Created by David Nemec on 17/08/2017.
//  Copyright © 2017 David Nemec. All rights reserved.
//


extension UIViewController {
    open func embeddedInNavigationController() -> Bool {
        return false
    }
}

extension UIViewController {
    public func isVisible() -> Bool {
        return self.isViewLoaded && self.view.window != nil
    }
}

extension UIViewController {

    public func enableTabBar(_ isEnabled: Bool) {
        if let _tabBarItems = tabBarController?.tabBar.items {
            for tabBarItem in _tabBarItems {
                tabBarItem.isEnabled = isEnabled
            }
        }
    }

    public var currentOrientationIsPortrait: Bool {
        return UIDevice.current.orientation == UIDeviceOrientation.portrait || UIDevice.current.orientation == .portraitUpsideDown
    }

    public func setTabBarVisible(visible: Bool, animated: Bool) {
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time

        // bail if the current state matches the desired state
        if isTabBarVisible == visible { return }
        guard let frame = self.tabBarController?.tabBar.frame else {
            return
        }

        // get a frame calculation ready

        let height = (frame.size.height)
        let offsetY = (visible ? -height : height)

        // zero duration means no animation
        let duration: TimeInterval = (animated ? 0.3 : 0.0)

        //  animate the tabBar
        UIView.animate(withDuration: duration) {
            var viewFrame = self.view.frame
            viewFrame.size.height += offsetY
            self.view.frame = viewFrame
            self.tabBarController?.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY * 1.5)
            return
        }
    }

    public var isTabBarVisible: Bool {
        return (self.tabBarController?.tabBar.frame.origin.y ?? 0) < self.view.frame.maxY + 10
    }
    
}
