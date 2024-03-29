// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "WMATA",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "WMATA",
            targets: ["WMATA"]
        ),
        .library(
            name: "MetroGTFS",
            targets: ["MetroGTFS"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-protobuf.git",
            .upToNextMajor(from: .init(1, 18, 0))
        ),
        .package(
            url: "https://github.com/venmo/DVR.git",
            .upToNextMajor(from: .init(2, 0, 0))
        ),
        .package(
            url: "https://github.com/apple/swift-docc-plugin",
            .upToNextMajor(from: .init(1, 0, 0))
        ),
        .package(
            url: "https://github.com/stephencelis/SQLite.swift.git",
            .upToNextMinor(from: .init(0, 14, 1))
        )
    ],
    targets: [
        .target(
            name: "WMATA",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf")
            ]
        ),
        .testTarget(
            name: "WMATATests",
            dependencies: ["WMATA", "DVR"],
            resources: [.process("Fixtures")]
        ),
        .target(
            name: "MetroGTFS",
            dependencies: [
                .product(name: "SQLite", package: "SQLite.swift"),
                "WMATA"
            ],
            resources: [
                .copy("MetroGTFS.sqlite3")
            ]
        ),
        .testTarget(
            name: "MetroGTFSTests",
            dependencies: [
                "MetroGTFS"
            ]
        )
    ]
)
