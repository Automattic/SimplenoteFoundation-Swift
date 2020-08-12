// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "SimplenoteFoundation",
    platforms: [.macOS(.v10_13),
                .iOS(.v11)],
    products: [
        .library(
            name: "SimplenoteFoundation",
            targets: ["SimplenoteFoundation"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "SimplenoteFoundation",
                path: "Sources/SimplenoteFoundation"),
        .testTarget(name: "SimplenoteFoundationTests",
                    dependencies: ["SimplenoteFoundation"])
    ],
    swiftLanguageVersions: [.v5]
)
