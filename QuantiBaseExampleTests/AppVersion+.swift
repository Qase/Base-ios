//
//  AppVersion+.swift
//  QuantiBaseExampleTests
//
//  Created by Martin Troup on 05/08/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import XCTest
@testable import QuantiBase

class AppVersion_: XCTestCase {

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
