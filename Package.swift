// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FlooidImages",
    platforms: [.iOS(.v13)],
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
    ]
)
