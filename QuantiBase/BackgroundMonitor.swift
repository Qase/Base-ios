//
//  SoftBackgroundMonitor.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 04.01.17.
//  Copyright © 2017 quanti. All rights reserved.
//

import Foundation

public protocol BackgroundMonitorDelegate: class {
    func applicationDidEnterBackground(_ sender: BackgroundMonitorService)
    func applicationWillEnterForeground(_ sender: BackgroundMonitorService)
    func applicationDidFinishLaunching(_ sender: BackgroundMonitorService)
    func applicationDidBecomeActive(_ sender: BackgroundMonitorService)
    func applicationWillResignActive(_ sender: BackgroundMonitorService)
    func applicationDidReceiveMemoryWarning(_ sender: BackgroundMonitorService)
    func applicationWillTerminate(_ sender: BackgroundMonitorService)
}

extension BackgroundMonitorDelegate {
    public func applicationDidEnterBackground(_ sender: BackgroundMonitorService) {}
    public func applicationWillEnterForeground(_ sender: BackgroundMonitorService) {}
    public func applicationDidFinishLaunching(_ sender: BackgroundMonitorService) {}
    public func applicationDidBecomeActive(_ sender: BackgroundMonitorService) {}
    public func applicationWillResignActive(_ sender: BackgroundMonitorService) {}
    public func applicationDidReceiveMemoryWarning(_ sender: BackgroundMonitorService) {}
    public func applicationWillTerminate(_ sender: BackgroundMonitorService) {}
}

public class BackgroundMonitorService: NSObject {
    public weak var delegate: BackgroundMonitorDelegate?

    public required override init() {
        super.init()
        registerForNotifications()
    }

}

extension BackgroundMonitorService: Notifying {
    public func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidEnterBackground),
                                               name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterForeground),
                                               name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidFinishLaunching),
                                               name: NSNotification.Name.UIApplicationDidFinishLaunching, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidBecomeActive),
                                               name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive),
                                               name: NSNotification.Name.UIApplicationWillResignActive, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidReceiveMemoryWarning),
                                               name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillTerminate),
                                               name: NSNotification.Name.UIApplicationWillTerminate, object: nil)
    }

    @objc fileprivate func applicationDidEnterBackground() {
        delegate?.applicationDidEnterBackground(self)
    }

    @objc fileprivate func applicationWillEnterForeground() {
        delegate?.applicationWillEnterForeground(self)
    }

    @objc fileprivate func applicationDidFinishLaunching() {
        delegate?.applicationDidFinishLaunching(self)
    }

    @objc fileprivate func applicationDidBecomeActive() {
        delegate?.applicationDidBecomeActive(self)
    }

    @objc fileprivate func applicationWillResignActive() {
        delegate?.applicationWillResignActive(self)
    }

    @objc fileprivate func applicationDidReceiveMemoryWarning() {
        delegate?.applicationDidReceiveMemoryWarning(self)
    }

    @objc fileprivate func applicationWillTerminate() {
        delegate?.applicationWillTerminate(self)
    }
}
