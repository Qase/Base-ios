//
//  ReachabilityService.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 21.12.16.
//  Copyright © 2016 quanti. All rights reserved.
//

import Foundation
import CoreTelephony
import RxSwift

public enum ConnectivityState {
    case notReachable
    case reachableViaWifi
    case reachableViaWWAN2G
    case reachableViaWWAN3G
    case reachableViaWWAN4G
}

public class ReachabilityService {
    public static let shared = ReachabilityService()

	private let _connectivityChanged = PublishSubject<ConnectivityState>()
	public var connectivityChanged: Observable<ConnectivityState> {
		return _connectivityChanged.asObservable()
	}

    private let reachability = Reachability.forInternetConnection()

    public var connectivityState: ConnectivityState {
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
        @unknown default:
            fatalError("\(#function) Given case is not covered!")
        }
    }

	public var isConnected: Bool {
		return connectivityState == .notReachable ? false : true
	}

	private let bag = DisposeBag()

    private init() {
        reachability?.startNotifier()

		let center = NotificationCenter.default

		center.rx.notification(NSNotification.Name.reachabilityChanged)
			.map { [weak self] _ in self?.connectivityState }
			.filterNil()
			.bind(to: _connectivityChanged)
			.disposed(by: bag)
    }

    deinit {
        reachability?.stopNotifier()
    }
}
