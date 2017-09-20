//
//  StringExtension.swift
//  QuantiBaseTests
//
//  Created by Martin Troup on 20/09/2017.
//  Copyright © 2017 David Nemec. All rights reserved.
//

import XCTest

class StringExtension: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReplace() {
        XCTAssertEqual("Testyng functyon".replace("y", replacement: "i"), "Testing function")
    }

    func testIndex() {
        XCTAssertEqual("Hello"[1], "e")
    }
    
    func testToJSONobject() {
        let dict = ("{\"name\": \"Test\"}".JSON) as! [String: String]
        XCTAssertEqual(dict["name"], "Test")
    }

    func testToJSONarray() {
        let array = ("[1, 2, 3, 4]".JSON) as! [Int]
        XCTAssertEqual(array.count, 4)
        XCTAssertEqual(array[2], 3)
    }

    func testToData() {
        XCTAssertEqual("Test".data!.hashValue, 371876)
        XCTAssertEqual("Test".data!.count, 4)
    }

    func testIndexOf() {
        XCTAssertEqual("Hello".firstIndex(of: "l"), 2)
    }

}
