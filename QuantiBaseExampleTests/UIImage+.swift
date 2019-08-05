//
//  UIImage+.swift
//  QuantiBaseExampleTests
//
//  Created by Martin Troup on 05/08/2019.
//  Copyright © 2019 David Nemec. All rights reserved.
//

import XCTest

class UIImage_: XCTestCase {

    func testResize() {
        func testImageResize() {
            let originalImage = #imageLiteral(resourceName: "close")
            
            let scaledImage = originalImage.resized(toSize: CGSize.init(width: 200, height: 200))
            
            XCTAssertEqual(scaledImage.size.width, 200)
            XCTAssertEqual(scaledImage.size.height, 200)
        }
    }
}
