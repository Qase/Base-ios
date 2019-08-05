//
//  TimeInterval+stringRepresentation.swift
//  QuantiBaseExampleTests
//
//  Created by Martin Troup on 05/08/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import XCTest

class TimeInterval_stringRepresentation: XCTestCase {

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
