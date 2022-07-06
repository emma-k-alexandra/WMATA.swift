// swift-tools-version:5.6
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
            url: "https://github.com/apple/swift-protobuf.git",
            .upToNextMajor(from: .init(1, 18, 0))
        ),
        .package(
            url: "https://github.com/venmo/DVR.git",
            .upToNextMajor(from: .init(2, 0, 0))
        ),
        .package(
            url: "https://github.com/apple/swift-docc-plugin",
            from: "1.0.0"
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
    ]
)
