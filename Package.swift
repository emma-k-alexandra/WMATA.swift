// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "WMATA",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "WMATA",
            targets: ["WMATA"]
        ),
    ],
    dependencies: [
        .package(
            name: "GTFS",
            url: "https://github.com/emma-k-alexandra/GTFS.git",
            .upToNextMajor(from: .init(1, 0, 1))
        ),
        .package(
            name: "DVR",
            url: "https://github.com/venmo/DVR.git",
            .upToNextMajor(from: .init(2, 0, 0))
        ),
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
            dependencies: ["WMATA", "DVR"],
            resources: [.process("Fixtures")]
        ),
    ]
)
