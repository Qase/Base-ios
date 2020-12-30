// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QuantiBase",
    platforms: [
        .iOS(.v12), .macOS(.v10_13),
    ],
    products: [
        .library(
            name: "QuantiBase",
            targets: ["QuantiBase"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.1.1")),
        .package(name: "Overture", url: "https://github.com/pointfreeco/swift-overture.git", from: "0.5.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", from: "4.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "QuantiBase",
            dependencies: [.product(name: "RxSwift", package: "RxSwift"),
                           .product(name: "RxCocoa", package: "RxSwift"),
                           "Overture",
                           "SnapKit",
                           "RxDataSources",
            ],
            path: "QuantiBase",
            exclude: ["macos/Info.plist", "ios/Info.plist", "ios/QAssets.xcassets"],
            sources: ["common", "ios", "macos"]
            ),
        .testTarget(name: "QuantiBaseTests",
                    dependencies: [.target(name: "QuantiBase")],
                    path: "QuantiBaseTests")
    ]
)
