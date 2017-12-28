//
//  ConnectivityManager.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 21.12.16.
//  Copyright © 2016 quanti. All rights reserved.
//

import Foundation
import CoreTelephony

public enum ConnectivityState {
    case notReachable
    case reachableViaWifi
    case reachableViaWWAN2G
    case reachableViaWWAN3G
    case reachableViaWWAN4G
}

public protocol ConnectivityManagerDelegate: BasicDelegate {
    func connectivityDidChange()
}

public class ConnectivityManager: Notifying, MultipleDelegating {
    public static let shared = ConnectivityManager()

    public typealias GenericDelegateType = ConnectivityManagerDelegate
    public var delegates: [String:WeakDelegate]

    private var reachability: Reachability?

    public var connectivityState: ConnectivityState {
        return getConnectivityState()
    }

    private init() {
        delegates = [String: WeakDelegate]()

        reachability = Reachability.forInternetConnection()
        reachability?.startNotifier()

        registerForNotifications()
    }

    deinit {
        reachability?.stopNotifier()
    }

    public func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(connectivityDidChange), name: NSNotification.Name.reachabilityChanged, object: nil)
    }

    @objc private func connectivityDidChange() {
        let delegates: [ConnectivityManagerDelegate] = getUnwrappedDelegates()
            for delegate in delegates {
                delegate.connectivityDidChange()
            }
    }

    private func getConnectivityState() -> ConnectivityState {
        guard let reachability = Reachability.forInternetConnection() else {
            return .notReachable
        }

        switch reachability.currentReachabilityStatus() {
        case .NotReachable:
            return .notReachable
        case .ReachableViaWiFi:
            return .reachableViaWifi
        case .ReachableViaWWAN:
            switch CTTelephonyNetworkInfo().currentRadioAccessTechnology {
            case CTRadioAccessTechnologyGPRS?,
                 CTRadioAccessTechnologyEdge?,
                 CTRadioAccessTechnologyCDMA1x?:
                return .reachableViaWWAN2G
            case CTRadioAccessTechnologyWCDMA?,
                 CTRadioAccessTechnologyHSDPA?,
                 CTRadioAccessTechnologyHSUPA?,
                 CTRadioAccessTechnologyCDMAEVDORev0?,
                 CTRadioAccessTechnologyCDMAEVDORevA?,
                 CTRadioAccessTechnologyCDMAEVDORevB?,
                 CTRadioAccessTechnologyeHRPD?:
                return .reachableViaWWAN3G
            case CTRadioAccessTechnologyLTE?:
                return .reachableViaWWAN4G
            default:
                return .notReachable
            }
        }
    }

    public func isConnected() -> Bool {
        return connectivityState == .notReachable ? false : true
    }

}
