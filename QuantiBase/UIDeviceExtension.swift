//
//  UIDeviceExtension.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 10.02.17.
//  Copyright © 2017 quanti. All rights reserved.
//

import Foundation

public enum DeviceType {
    case iPodTouch5, iPodTouch6, iPhone4, iPhone4S, iPhone5, iPhone5C, iPhone5S,
         iPhone6, iPhone6Plus, iPhone6S, iPhone6SPlus, iPhone7, iPhone7Plus, iPhoneSE,
         iPad2, iPad3, iPad4, iPadAir, iPadAir2, iPadMini, iPadMini2, iPadMini3, iPadMini4,
         iPadPro, appleTV, simulator, other

    // swiftlint:disable:next cyclomatic_complexity
    public static func from(_ deviceTypeString: String) -> DeviceType {
        switch deviceTypeString {
        case "iPod5,1":                                 return iPodTouch5
        case "iPod7,1":                                 return iPodTouch6
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return iPhone4
        case "iPhone4,1":                               return iPhone4S
        case "iPhone5,1", "iPhone5,2":                  return iPhone5
        case "iPhone5,3", "iPhone5,4":                  return iPhone5C
        case "iPhone6,1", "iPhone6,2":                  return iPhone5S
        case "iPhone7,2":                               return iPhone6
        case "iPhone7,1":                               return iPhone6Plus
        case "iPhone8,1":                               return iPhone6S
        case "iPhone8,2":                               return iPhone6SPlus
        case "iPhone9,1", "iPhone9,3":                  return iPhone7
        case "iPhone9,2", "iPhone9,4":                  return iPhone7Plus
        case "iPhone8,4":                               return iPhoneSE
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           return iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           return iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":           return iPadAir
        case "iPad5,3", "iPad5,4":                      return iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":           return iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           return iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           return iPadMini3
        case "iPad5,1", "iPad5,2":                      return iPadMini4
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return iPadPro
        case "AppleTV5,3":                              return appleTV
        case "i386", "x86_64":                          return simulator
        default:                                        return other
        }
    }

    public func getResolutionGroup() -> ResolutionGroup? {
        switch self {
        case .iPhone5, .iPhone5C, .iPhone5S, .iPhoneSE, .iPodTouch5, .iPodTouch6:
            return .lr320x568
        case .iPhone6, .iPhone6S, .iPhone7:
            return .lr375x667
        case .iPhone6Plus, .iPhone6SPlus, .iPhone7Plus:
            return .lr414x736
        case .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4:
            return .lr768x1024
        case .iPad2, .iPad3, .iPad4, .iPadAir, .iPadAir2:
            return .lr768x1024
        case .iPadPro:
            return .lr1024x1366
        case .simulator:
            return isiPhone ? .lr320x568 : .lr768x1024
        default:
            return .lr320x568
        }
    }

}

// NOTE: Enum values represent logical resolutions while their raw values represent real resolutions
public enum ResolutionGroup: String {
    case lr320x568 = "r640x1136"
    case lr375x667 = "r750x1334"
    case lr414x736 = "r1242x2208"
    case lr768x1024 = "r1536x2048"
    case lr1024x1366 = "r2048x2732"

    public static func from(_ size: CGSize) -> ResolutionGroup? {
        return ResolutionGroup(rawValue: "r\(size.width)x\(size.height)")
    }
}

extension UIDevice {
    public static var type: DeviceType {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let deviceTypeString = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return DeviceType.from(deviceTypeString)
    }
}
