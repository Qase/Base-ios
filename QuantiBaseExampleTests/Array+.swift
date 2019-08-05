//
//  Array+.swift
//  QuantiBaseExampleTests
//
//  Created by Martin Troup on 05/08/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import XCTest

class Array_: XCTestCase {

    func testArrayRemove() {
        var array = ["AAA", "bbb", "cCc", "DdD"]
        
        array.removeFirst(object: "AAA")
        XCTAssertEqual(array,  ["bbb", "cCc", "DdD"], "Error removed failed")
        
        array.removeFirst(object: "AAA")
        XCTAssertEqual(array,  ["bbb", "cCc", "DdD"], "Error removed failed")
        
        array.removeFirst(object: "bbb")
        XCTAssertEqual(array,  ["cCc", "DdD"], "Error removed failed")
        
        array.removeFirst(object: "DdD")
        XCTAssertEqual(array,  ["cCc"], "Error removed failed")
        
        array.removeFirst(object: "cCc")
        XCTAssertEqual(array,  [], "Error removed failed")
    }

}
