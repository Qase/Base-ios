//
//  UnitsConverterService.swift
//  QuantiBase
//
//  Created by George Ivannikov on 2/24/20.
//  Copyright © 2020 David Nemec. All rights reserved.
//

import Foundation

struct UnitsConverter {
    private let bytes: Int64

    private var kilobytes: Double {
      Double(bytes) / 1_024
    }

    private var megabytes: Double {
      kilobytes / 1_024
    }

    private var gigabytes: Double {
      megabytes / 1_024
    }

    init(bytes: Int64) {
      self.bytes = bytes
    }

    func getReadableUnit() -> String {
      switch bytes {
      case 0..<1_024:
        return "\(bytes) b"
      case 1_024..<(1_024 * 1_024):
        return "\(String(format: "%.2f", kilobytes)) Kb"
      case 1_024..<(1_024 * 1_024 * 1_024):
        return "\(String(format: "%.2f", megabytes)) Mb"
      case (1_024 * 1_024 * 1_024)...Int64.max:
        return "\(String(format: "%.2f", gigabytes)) Gb"
      default:
        return "\(bytes) b"
      }
    }

    func isLessThan(mB megaBytes: Int) -> Bool {
      (bytes / 1_024) / 1_024 < megaBytes
    }
}
