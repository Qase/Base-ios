//
//  AppLifecycleService.swift
//  2NLock
//
//  Created by Martin Troup on 11/01/2019.
//  Copyright © 2019 Quanti. All rights reserved.
//

import UIKit
import RxSwift

public class AppLifecycleService {
	public static let shared = AppLifecycleService()

	private let _willEnterForeground = PublishSubject<Notification>()
	public var willEnterForeground: Observable<Notification> {
		_willEnterForeground.asObservable()
	}

	private let _didEnterBackground = PublishSubject<Notification>()
	public var didEnterBackground: Observable<Notification> {
		_didEnterBackground.asObservable()
	}

	private let _didFinishLaunching = PublishSubject<Notification>()
	public var didFinishLaunching: Observable<Notification> {
		_didFinishLaunching.asObservable()
	}

	private let _didBecomeActive = PublishSubject<Notification>()
	public var didBecomeActive: Observable<Notification> {
		_didBecomeActive.asObservable()
	}

	private let _willResignActive = PublishSubject<Notification>()
	public var willResignActive: Observable<Notification> {
		_willResignActive.asObservable()
	}

	private let _didReceiveMemoryWarning = PublishSubject<Notification>()
	public var didReceiveMemoryWarning: Observable<Notification> {
		_didReceiveMemoryWarning.asObservable()
	}

	private let _willTerminate = PublishSubject<Notification>()
	public var willTerminate: Observable<Notification> {
		_willTerminate.asObservable()
	}

	private let bag = DisposeBag()

	private init() {
		let center = NotificationCenter.default

		center.rx.notification(UIApplication.willEnterForegroundNotification)
			.bind(to: _willEnterForeground)
			.disposed(by: bag)

		center.rx.notification(UIApplication.didEnterBackgroundNotification)
			.bind(to: _didEnterBackground)
			.disposed(by: bag)

		center.rx.notification(UIApplication.didFinishLaunchingNotification)
			.bind(to: _didFinishLaunching)
			.disposed(by: bag)

		center.rx.notification(UIApplication.didBecomeActiveNotification)
			.bind(to: _didBecomeActive)
			.disposed(by: bag)

		center.rx.notification(UIApplication.willResignActiveNotification)
			.bind(to: _willResignActive)
			.disposed(by: bag)

		center.rx.notification(UIApplication.didReceiveMemoryWarningNotification)
			.bind(to: _didReceiveMemoryWarning)
			.disposed(by: bag)

		center.rx.notification(UIApplication.willTerminateNotification)
			.bind(to: _willTerminate)
			.disposed(by: bag)
	}
}
