//
//  Collection+reduce.swift
//  QuantiBaseExampleTests
//
//  Created by Martin Troup on 05/08/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import XCTest

class Collection_reduce: XCTestCase {

    func testReduce() {
        let averageNumber = [1, 2, 4, 3, 5, 17, 39].reduce(0) { (count, avg, next) -> Double in
            avg + (Double(next) / Double(count))
        }
        XCTAssertEqual(round(1000 * averageNumber) / 1000, 10.143)
    }

}
