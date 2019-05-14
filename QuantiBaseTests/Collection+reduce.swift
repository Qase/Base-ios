//
//  Collection+ReduceExtension.swift
//  QuantiBaseTests
//
//  Created by Martin Troup on 20/09/2017.
//  Copyright © 2017 David Nemec. All rights reserved.
//

import XCTest

class Collection_ReduceExtension: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReduce() {
        let averageNumber = [1, 2, 4, 3, 5, 17, 39].reduce(0) { (count, avg, next) -> Double in
            avg + (Double(next) / Double(count))
        }
        XCTAssertEqual(round(1000 * averageNumber) / 1000, 10.143)
    }
    
}
