//
//  ArrayExtension.swift
//  QuantiBase
//
//  Created by Jakub Prusa on 26.08.17.
//  Copyright © 2017 David Nemec. All rights reserved.
//

import XCTest

class ArrayExtension: XCTestCase {

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
