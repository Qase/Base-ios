//
//  String+random.swift
//  QuantiBase
//
//  Created by George Ivannikov on 3/25/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//

import Foundation

extension String {
    static func random(length: Int = 10) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map { _ in letters.randomElement() ?? "_" })
    }
}
