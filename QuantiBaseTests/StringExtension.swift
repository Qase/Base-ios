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

    func testSubscript() {
        XCTAssertEqual("Hello"[1], "e")
    }

    func testSubscriptRange1() {
        XCTAssertEqual("Good Morning"[3..<3], nil)
    }

    func testSubscriptRange2() {
        XCTAssertEqual("Good Morning"[-1..<3], nil)
    }

    func testSubscriptRange3() {
        XCTAssertEqual("Good Morning"[10..<14], nil)
    }

    func testSubscriptRange4() {
        XCTAssertEqual("Good Morning"[3..<6], "d M")
    }
    
    func testToJSONobject() {
        let dict = ("{\"name\": \"Test\"}".json) as! [String: String]
        XCTAssertEqual(dict["name"], "Test")
    }

    func testToJSONarray() {
        let array = ("[1, 2, 3, 4]".json) as! [Int]
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
