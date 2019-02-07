//
//  AppLifecycleService.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 04.01.17.
//  Copyright © 2017 quanti. All rights reserved.
//

import Foundation

public protocol AppLifecycleServiceDelegate: class {
    func applicationDidEnterBackground()
    func applicationWillEnterForeground()
    func applicationDidFinishLaunching()
    func applicationDidBecomeActive()
    func applicationWillResignActive()
    func applicationDidReceiveMemoryWarning()
    func applicationWillTerminate()
}

extension AppLifecycleServiceDelegate {
    public func applicationDidEnterBackground() {}
    public func applicationWillEnterForeground() {}
    public func applicationDidFinishLaunching() {}
    public func applicationDidBecomeActive() {}
    public func applicationWillResignActive() {}
    public func applicationDidReceiveMemoryWarning() {}
    public func applicationWillTerminate() {}
}

public class AppLifecycleService: MultipleDelegating {
	public static let shared = AppLifecycleService()

	public typealias GenericDelegateType = AppLifecycleServiceDelegate
	public var delegates = [String : WeakDelegate]()

    private init() {
        registerForNotifications()
    }

}

extension AppLifecycleService: Notified {
    public func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidEnterBackground),
											   name: UIApplication.didEnterBackgroundNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidFinishLaunching),
                                               name: UIApplication.didFinishLaunchingNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive),
                                               name: UIApplication.willResignActiveNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidReceiveMemoryWarning),
                                               name: UIApplication.didReceiveMemoryWarningNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillTerminate),
                                               name: UIApplication.willTerminateNotification, object: nil)
    }

	@objc fileprivate func applicationDidEnterBackground() {
		unwrappedDelegates.forEach { $0.applicationDidEnterBackground() }
    }

    @objc fileprivate func applicationWillEnterForeground() {
		unwrappedDelegates.forEach { $0.applicationWillEnterForeground() }
    }

    @objc fileprivate func applicationDidFinishLaunching() {
		unwrappedDelegates.forEach { $0.applicationDidFinishLaunching() }
    }

    @objc fileprivate func applicationDidBecomeActive() {
		unwrappedDelegates.forEach { $0.applicationDidBecomeActive() }
    }

    @objc fileprivate func applicationWillResignActive() {
		unwrappedDelegates.forEach { $0.applicationWillResignActive() }
    }

    @objc fileprivate func applicationDidReceiveMemoryWarning() {
		unwrappedDelegates.forEach { $0.applicationDidReceiveMemoryWarning() }
    }

    @objc fileprivate func applicationWillTerminate() {
		unwrappedDelegates.forEach { $0.applicationWillTerminate() }
    }
}
