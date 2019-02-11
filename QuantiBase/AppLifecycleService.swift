//
//  AppLifecycleService.swift
//  2NLock
//
//  Created by Martin Troup on 11/01/2019.
//  Copyright © 2019 Quanti. All rights reserved.
//

import Foundation

import UIKit
import RxSwift

public class AppLifecycleService {
	public static let shared = AppLifecycleService()

	private let _willEnterForeground = PublishSubject<Notification>()
	public var willEnterForeground: Observable<Notification> {
		return _willEnterForeground.asObservable()
	}

	private let _didEnterBackground = PublishSubject<Notification>()
	public var didEnterBackground: Observable<Notification> {
		return _didEnterBackground.asObservable()
	}

	private let _didFinishLaunching = PublishSubject<Notification>()
	public var didFinishLaunching: Observable<Notification> {
		return _didFinishLaunching.asObservable()
	}

	private let _didBecomeActive = PublishSubject<Notification>()
	public var didBecomeActive: Observable<Notification> {
		return _didBecomeActive.asObservable()
	}

	private let _willResignActive = PublishSubject<Notification>()
	public var willResignActive: Observable<Notification> {
		return _willResignActive.asObservable()
	}

	private let _didReceiveMemoryWarning = PublishSubject<Notification>()
	public var didReceiveMemoryWarning: Observable<Notification> {
		return _didReceiveMemoryWarning.asObservable()
	}

	private let _willTerminate = PublishSubject<Notification>()
	public var willTerminate: Observable<Notification> {
		return _willTerminate.asObservable()
	}

	private let bag = DisposeBag()

	private init() {
		let center = NotificationCenter.default

		center.rx.notification(NSNotification.Name.UIApplicationWillEnterForeground)
			.bind(to: _willEnterForeground)
			.disposed(by: bag)

		center.rx.notification(NSNotification.Name.UIApplicationDidEnterBackground)
			.bind(to: _didEnterBackground)
			.disposed(by: bag)

		center.rx.notification(NSNotification.Name.UIApplicationDidFinishLaunching)
			.bind(to: _didFinishLaunching)
			.disposed(by: bag)

		center.rx.notification(NSNotification.Name.UIApplicationDidBecomeActive)
			.bind(to: _didBecomeActive)
			.disposed(by: bag)

		center.rx.notification(NSNotification.Name.UIApplicationWillResignActive)
			.bind(to: _willResignActive)
			.disposed(by: bag)

		center.rx.notification(NSNotification.Name.UIApplicationDidReceiveMemoryWarning)
			.bind(to: _didReceiveMemoryWarning)
			.disposed(by: bag)

		center.rx.notification(NSNotification.Name.UIApplicationWillTerminate)
			.bind(to: _willTerminate)
			.disposed(by: bag)
	}
}
