// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TitechPortalCore",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TitechPortalCore",
            targets: ["TitechPortalCore"]),
        .executable(
            name: "TitechPortalCoreRun",
            targets: ["TitechPortalCoreRun"]
        )
    ],
    dependencies: [
            .package(url: "https://github.com/tid-kijyun/Kanna.git", from: "5.2.2"),
        ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TitechPortalCore",
            dependencies: ["Kanna"]),
        .target(
            name: "TitechPortalCoreRun",
            dependencies: ["TitechPortalCore"]
        ),
        .testTarget(
            name: "TitechPortalCoreTests",
            dependencies: ["TitechPortalCore"]),
    ]
)
