//
//  String+.swift
//  QuantiBaseExampleTests
//
//  Created by Martin Troup on 05/08/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import XCTest

class String_: XCTestCase {

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
        let data = "Test".data!
        
        XCTAssertEqual(data.count, 4)
        XCTAssertEqual(data.string!, "Test")
    }
    
    func testIndexOf() {
        XCTAssertEqual("Hello".firstIndex(of: "l"), 2)
    }


}
