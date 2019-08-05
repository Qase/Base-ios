//
//  AppVersion.swift
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

    func testAppVersion() {
		let appVersion = AppVersion(major: 1, minor: 2, bug: 0)
		XCTAssertEqual(appVersion.major, 1)
		XCTAssertEqual(appVersion.minor, 2)
		XCTAssertEqual(appVersion.bug, 0)

        let appVersionStorageKey = "appVersionStorageUnitTest"
        
		let isStored = UserDefaults.standard.set(codable: appVersion, forKey: appVersionStorageKey)
		XCTAssertEqual(isStored, true)

		let restoredAppVersion: AppVersion? = UserDefaults.standard.codable(forKey: appVersionStorageKey)
		XCTAssertEqual(appVersion, restoredAppVersion)
		XCTAssertTrue(UserDefaults.standard.object(forKey: appVersionStorageKey) != nil)

		UserDefaults.standard.removeObject(forKey: appVersionStorageKey)

		XCTAssertTrue(UserDefaults.standard.object(forKey: appVersionStorageKey) == nil)
    }
}
