//
//  UIViewController+isModal.swift
//  QuantiBase
//
//  Created by Jakub Prusa on 30.08.17.
//  Copyright © 2017 David Nemec. All rights reserved.
//

import Foundation

extension UIViewController {
    var isModal: Bool {
        if let navigationController = self.navigationController {
            if navigationController.viewControllers.first != self {
                return false
            }
        }

        if self.presentingViewController != nil {
            return true
        }

        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        }

        if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
}
