//
//  UIImage+ResizeExtension.swift
//  QuantiBase
//
//  Created by Jakub Prusa on 8/25/17.
//  Copyright © 2017 David Nemec. All rights reserved.
//

import XCTest
@testable import QuantiBase

class UIImage_ResizeExtension: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testResize() {
        func testImageResize() {
            let originalImage = #imageLiteral(resourceName: "close")

			let scaledImage = originalImage.resized(toSize: CGSize.init(width: 200, height: 200))

            XCTAssertEqual(scaledImage.size.width, 200)
            XCTAssertEqual(scaledImage.size.height, 200)
        }
    }

    
}
