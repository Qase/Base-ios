//
//  Date+.swift
//  QuantiBaseExampleTests
//
//  Created by Martin Troup on 05/08/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import XCTest

class Date_: XCTestCase {

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
