// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "WMATA",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v5)
    ],
    products: [
        .library(
            name: "WMATA",
            targets: ["WMATA"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/emma-k-alexandra/GTFS.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "WMATA",
            dependencies: [
                "GTFS",
            ]
        ),
        .testTarget(
            name: "WMATATests",
            dependencies: ["WMATA"]
        ),
    ]
)
