// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWScreenRecorder",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "WWScreenRecorder", targets: ["WWScreenRecorder"]),
    ],
    targets: [
        .target(name: "WWScreenRecorder", resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
