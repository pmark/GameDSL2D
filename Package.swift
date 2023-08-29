// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GameDSL2D",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "GameDSL2D",
            targets: ["GameDSL2D"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/InvadingOctopus/octopuskit", .upToNextMajor(from: "3.2.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "GameDSL2D",
            dependencies: [
                .product(name: "OctopusKit", package: "octopuskit"),
            ]),
        .testTarget(
            name: "GameDSL2DTests",
            dependencies: ["GameDSL2D"]),
    ]
)
