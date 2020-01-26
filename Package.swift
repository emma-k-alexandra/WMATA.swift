// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "WMATA",
    products: [
        .library(
            name: "WMATA",
            targets: ["WMATA"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.7.0"),
    ],
    targets: [
        .target(
            name: "WMATA",
            dependencies: [
                "SwiftProtobuf"
            ]
        ),
        .testTarget(
            name: "WMATATests",
            dependencies: ["WMATA"]
        )
    ]
)
