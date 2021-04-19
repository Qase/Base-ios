//
//  BluetoothService.swift
//  2NLock
//
//  Created by Martin Troup on 23/10/2017.
//  Copyright © 2017 Quanti. All rights reserved.
//

import Foundation
import CoreBluetooth
import RxSwift

public class BluetoothService: NSObject {
	private let _stateObservable = PublishSubject<CBManagerState>()
	public lazy var stateObservable: Observable<CBManagerState> = {
		_stateObservable.asObservable()
			.startWith(state)
			.distinctUntilChanged()
			.share(replay: 1)
	}()

	public var state: CBManagerState {
		bluetoothManager.state
	}

	public var isBluetoothOn: Bool {
		bluetoothManager.state == .poweredOn
	}

	private let bluetoothManager = CBPeripheralManager()

	override init() {
		super.init()

		bluetoothManager.delegate = self
	}
}

// MARK: - CBPeripheralManagerDelegate implementation
extension BluetoothService: CBPeripheralManagerDelegate {
	public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        QuantiBaseEnv.current.logger.log("\(#function) - called from BluetoothService with new state: \(peripheral.state)", onLevel: .info)

		_stateObservable.onNext(peripheral.state)
	}

}
