// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BlurView",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "BlurView",
            targets: ["BlurView"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "BlurView", path: "Sources")
    ]
)
