// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "FlooidImages",
    platforms: [.iOS(.v13),.macOS(.v10_15)],
    products: [
        .library(
            name: "FlooidImages",
            targets: ["FlooidImages"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "FlooidImages",
            path: "FlooidImages",
            exclude: ["Info.plist"]
        )
    ],
    swiftLanguageVersions: [.v6]
)
