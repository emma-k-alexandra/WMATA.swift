// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "WMATA",
    products: [
        .library(
            name: "WMATA",
            targets: ["WMATA"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WMATA",
            dependencies: []
        ),
        .testTarget(
            name: "WMATATests",
            dependencies: ["WMATA"]
        )
    ]
)
