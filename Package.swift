// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "FlooidImages",
    platforms: [.iOS(.v11)],
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
            path: "FlooidImages"),
    ]
)
