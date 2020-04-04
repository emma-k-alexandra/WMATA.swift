// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "WMATA",
    products: [
        .library(
            name: "WMATA",
            type: .dynamic,
            targets: ["WMATA"]),
    ],
    dependencies: [
        .package(url: "https://github.com/emma-k-alexandra/GTFS.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "WMATA",
            dependencies: [
                "GTFS"
            ]
        ),
        .testTarget(
            name: "WMATATests",
            dependencies: ["WMATA"]
        )
    ]
)
