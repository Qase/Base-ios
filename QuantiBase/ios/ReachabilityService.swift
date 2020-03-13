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

    private let reachability = try? Reachability()

    public var connectivityState: ConnectivityState {
        guard let reachability = self.reachability else {
            return .notReachable
        }

        print(reachability.connection)

        switch reachability.connection {
        case .unavailable, .none:
            return .notReachable
        case .wifi:
            return .reachableViaWifi
        case .cellular:
            return connectivityStateForCellular()
        }
    }

	public var isConnected: Bool {
		return connectivityState == .notReachable ? false : true
	}

	private let bag = DisposeBag()

    private init() {
        try? reachability?.startNotifier()

		let center = NotificationCenter.default

		center.rx.notification(NSNotification.Name.reachabilityChanged)
			.map { [weak self] _ in self?.connectivityState }
			.filterNil()
			.bind(to: _connectivityChanged)
			.disposed(by: bag)
    }

    @available(iOS 12.0, *)
    private func connectivityStateForCellular() -> ConnectivityState {
        var connectionTypeToTechDict: [ConnectivityState: [String]] = [:]
        connectionTypeToTechDict[.reachableViaWWAN4G] = [CTRadioAccessTechnologyLTE]
        connectionTypeToTechDict[.reachableViaWWAN3G] = [CTRadioAccessTechnologyWCDMA,
                                                         CTRadioAccessTechnologyHSDPA,
                                                         CTRadioAccessTechnologyHSUPA,
                                                         CTRadioAccessTechnologyCDMAEVDORev0,
                                                         CTRadioAccessTechnologyCDMAEVDORevA,
                                                         CTRadioAccessTechnologyCDMAEVDORevB,
                                                         CTRadioAccessTechnologyeHRPD]
        connectionTypeToTechDict[.reachableViaWWAN2G] = [CTRadioAccessTechnologyGPRS,
                                                         CTRadioAccessTechnologyEdge,
                                                         CTRadioAccessTechnologyCDMA1x]

        let telephonyArrayContainsTech = { (telephonyParameters: [String: String], techsToSearch: [String]) -> Bool in
            telephonyParameters.map { $0.value }.contains(where: techsToSearch.contains)
        }

        let telephonyParameters = CTTelephonyNetworkInfo().serviceCurrentRadioAccessTechnology ?? [:]

        if telephonyArrayContainsTech(telephonyParameters, connectionTypeToTechDict[.reachableViaWWAN4G] ?? []) {
            return .reachableViaWWAN4G
        } else if telephonyArrayContainsTech(telephonyParameters, connectionTypeToTechDict[.reachableViaWWAN3G] ?? []) {
            return .reachableViaWWAN3G
        } else if telephonyArrayContainsTech(telephonyParameters, connectionTypeToTechDict[.reachableViaWWAN2G] ?? []) {
            return .reachableViaWWAN2G
        } else {
            return .notReachable
        }
    }

    deinit {
        reachability?.stopNotifier()
    }
}
