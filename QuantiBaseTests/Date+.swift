//
//  DateExtension.swift
//  QuantiBase
//
//  Created by Martin Troup on 19/09/2017.
//  Copyright © 2017 David Nemec. All rights reserved.
//

import XCTest

class DateExtension: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testToStringWithoutParameter() {
        let now = Date()
        let fullDateTimeRegex = "^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}:[0-9]{3}$"
        let fullDateTimePredicate = NSPredicate(format: "SELF MATCHES %@", fullDateTimeRegex)
        XCTAssertTrue(fullDateTimePredicate.evaluate(with: now.asString()))
    }

    func testtoTimeStringWithParameter() {
        let now = Date()
        let fullDateTimeRegex = "^[0-9]{2}.[0-9]{2}.[0-9]{2}$"
        let fullDateTimePredicate = NSPredicate(format: "SELF MATCHES %@", fullDateTimeRegex)
        XCTAssertTrue(fullDateTimePredicate.evaluate(with: now.asString("hh.mm.ss")))
    }

    func testOfDateTimeStringVariable() {
        let now = Date()
        let fullDateTimeRegex = "^[0-9]{2}:[0-9]{2}:[0-9]{2}$"
        let fullDateTimePredicate = NSPredicate(format: "SELF MATCHES %@", fullDateTimeRegex)
        XCTAssertTrue(fullDateTimePredicate.evaluate(with: now.timeString))
    }

    func testOfTimeStringVariable() {
        let now = Date()
        let fullDateTimeRegex = "^[0-9]{2} [A-Z][a-z]{1,}, [0-9]{2}:[0-9]{2}$"
        let fullDateTimePredicate = NSPredicate(format: "SELF MATCHES %@", fullDateTimeRegex)
        XCTAssertTrue(fullDateTimePredicate.evaluate(with: now.dateTimeString))
    }
    
}
