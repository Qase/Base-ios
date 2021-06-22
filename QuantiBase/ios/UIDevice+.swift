//
//  UIDeviceExtension.swift
//  2N-mobile-communicator
//
//  Created by Martin Troup on 10.02.17.
//  Copyright © 2017 quanti. All rights reserved.
//

import UIKit

public enum DeviceType {
    case iPodTouch5, iPodTouch6, iPodTouch7thGen,

         iPhone4, iPhone4S, iPhone5, iPhone5C, iPhone5S,
         iPhone6, iPhone6Plus, iPhone6S, iPhone6SPlus, iPhone7, iPhone7Plus, iPhoneSE,
         iPhone8, iPhone8Plus, iPhoneX, iPhoneXS, iPhoneXSMax, iPhoneXR,
         iPhone11, iPhone11Pro, iPhone11ProMax,
         iPhoneSE2ndGen,
         iPhone12mini, iPhone12, iPhone12Pro, iPhone12ProMax,

         iPad2, iPad3, iPad4, iPad5, iPad6,
         iPadAir, iPadAir2, iPadMini, iPadMini2, iPadMini3, iPadMini4,
         iPadPro9_7, iPadPro12_9, iPadPro12_9_2ndGen, iPadPro10_5, iPadPro11, iPadPro12_9_3rdGen, iPadPro12_9_4thGen,

         appleTV, appleTV4K, homePod, simulator, other

    // swiftlint:disable:next cyclomatic_complexity
    public static func from(_ deviceTypeString: String) -> DeviceType {
        switch deviceTypeString {
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
        case "iPhone10,1", "iPhone10,4":                return iPhone8
        case "iPhone10,2", "iPhone10,5":                return iPhone8Plus
        case "iPhone10,3", "iPhone10,6":                return iPhoneX
        case "iPhone11,2":                              return iPhoneXS
        case "iPhone11,4", "iPhone11,6":                return iPhoneXSMax
        case "iPhone11,8":                              return iPhoneXR
        case "iPhone12,1":                              return iPhone11
        case "iPhone12,3":                              return iPhone11Pro
        case "iPhone12,5":                              return iPhone11ProMax
        case "iPhone12,8":                              return iPhoneSE2ndGen
        case "iPhone13,1":                              return iPhone12mini
        case "iPhone13,2":                              return iPhone12
        case "iPhone13,3":                              return iPhone12Pro
        case "iPhone13,4":                              return iPhone12ProMax

        case "iPod5,1":                                 return iPodTouch5
        case "iPod7,1":                                 return iPodTouch6
        case "iPod9,1":                                 return iPodTouch7thGen

        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           return iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           return iPad4
        case "iPad6,11", "iPad6,12":                    return iPad5
        case "iPad7,5", "iPad7,6":                      return iPad6

        case "iPad4,1", "iPad4,2", "iPad4,3":           return iPadAir
        case "iPad5,3", "iPad5,4":                      return iPadAir2

        case "iPad2,5", "iPad2,6", "iPad2,7":           return iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           return iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           return iPadMini3
        case "iPad5,1", "iPad5,2":                      return iPadMini4

        case "iPad6,3", "iPad6,4":                      return iPadPro9_7
        case "iPad6,7", "iPad6,8":                      return iPadPro12_9
        case "iPad7,1", "iPad7,2":                      return iPadPro12_9_2ndGen
        case "iPad7,3", "iPad7,4":                      return iPadPro10_5
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return iPadPro11
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return iPadPro12_9_3rdGen
        case "iPad8,11", "iPad8,12":                    return iPadPro12_9_4thGen

        case "AppleTV5,3":                              return appleTV
        case "AppleTV6,2":                              return appleTV4K

        case "AudioAccessory1,1":                       return homePod
        case "i386", "x86_64":                          return simulator
        default:                                        return other
        }
    }

    public var resolutionGroup: ResolutionGroup? {
        switch self {
        case .iPhone5, .iPhone5C, .iPhone5S, .iPhoneSE, .iPodTouch5, .iPodTouch6:
            return .lr320x568
        case .iPhone6, .iPhone6S, .iPhone7, .iPhone8, .iPhoneX:
            return .lr375x667
        case .iPhone6Plus, .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
            return .lr414x736
        case .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4:
            return .lr768x1024
        case .iPad2, .iPad3, .iPad4, .iPadAir, .iPadAir2, .iPad5:
            return .lr768x1024
        case .iPadPro9_7:
            return .lr1024x1366
        case .simulator:
            return UIDevice.isiPhone ? .lr320x568 : .lr768x1024
        default:
            if UIDevice.isiPad {
                return .lr768x1024
            }
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
        ResolutionGroup(rawValue: "r\(size.width)x\(size.height)")
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

	public static var isSimulator: Bool {
		TARGET_OS_SIMULATOR != 0
	}

	public static var isiPhone: Bool {
		UIDevice.current.userInterfaceIdiom == .phone
	}

	public static var isiPad: Bool {
		UIDevice.current.userInterfaceIdiom == .pad
	}
}
