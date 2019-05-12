//
//  TimeInterval+stringRepresentation.swift
//  QuantiBase
//
//  Created by Jakub Prusa on 26.08.17.
//  Copyright © 2017 David Nemec. All rights reserved.
//

import XCTest
@testable import QuantiBase

class TimeInterval_IntervalAsStringExtension: XCTestCase {
    

    func testDeprecatedFormatter() {
        let timeInterval = TimeInterval(exactly: 98765)

        let test1  = timeInterval?.format()
        XCTAssertEqual(test1, "27:26:05:000", "Error in default formatter")

        let test2  = timeInterval?.format("hh")
        XCTAssertEqual(test2, "27", "Error in hour formatter")

        let test3  = timeInterval?.format("mm")
        XCTAssertEqual(test3, "26", "Error in minute formatter")

        let test4  = timeInterval?.format("ss")
        XCTAssertEqual(test4, "05", "Error in second formatter")

        let test5  = timeInterval?.format("hh_testing_ss")
        XCTAssertEqual(test5, "27_testing_05", "Error with custom word in format string")

    }


    func testNewFormatter() {
        let timeInterval = TimeInterval(exactly: 98765)

        let test1  = timeInterval?.format()
        XCTAssertEqual(test1, "27:26:05:000", "Error in default formatter")

        let test2  = timeInterval?.format("hh")
        XCTAssertEqual(test2, "27", "Error in hour formatter")

        let test3  = timeInterval?.format("mm")
        XCTAssertEqual(test3, "26", "Error in minute formatter")

        let test4  = timeInterval?.format("ss")
        XCTAssertEqual(test4, "05", "Error in second formatter")

        let test5  = timeInterval?.format("hh_testing_ss")
        XCTAssertEqual(test5, "27_testing_05", "Error with custom word in format string")
    }

    
}
