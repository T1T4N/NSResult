// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NSResultKit",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v2),
    ],
    products: [
        .library(name: "NSResultKit", targets: ["NSResultKit"]),
    ],
    targets: [
        .target(
            name: "NSResultKit"),
        .testTarget(
            name: "NSResultKitTests",
            dependencies: ["NSResultKit"]),
    ]
)
