//
//  AppVersionTests.swift
//  QuantiBaseTests
//
//  Created by Martin Troup on 21/03/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import XCTest
@testable import QuantiBase

class AppVersionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
		let appVersion = AppVersion(major: 1, minor: 2, bug: 0)
		XCTAssertEqual(appVersion.major, 1)
		XCTAssertEqual(appVersion.minor, 2)
		XCTAssertEqual(appVersion.bug, 0)

		let userDefaultsBundle = UserDefaultsBundle(key: "appVersionStorageUnitTest", storage: UserDefaults.standard)

		let isStored = appVersion.store(using: userDefaultsBundle)
		XCTAssertEqual(isStored, true)

		let restoredAppVersion: AppVersion? = AppVersion.restore(using: userDefaultsBundle)
		XCTAssertEqual(appVersion, restoredAppVersion)
		XCTAssertTrue(userDefaultsBundle.storage.object(forKey: userDefaultsBundle.key) != nil)

		restoredAppVersion?.remove(using: userDefaultsBundle)

		XCTAssertTrue(userDefaultsBundle.storage.object(forKey: userDefaultsBundle.key) == nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
