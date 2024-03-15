# WMATA.swift

WMATA.swift is a Swift interface to the [Washington Metropolitan Area Transit Authority API](https://developer.wmata.com).

## Install

### Requirements

- Swift 5.9
- Xcode 15

### Swift Package Manager

```swift
dependencies: [
    .package(
        name: "WMATA",
        url: "https://github.com/emma-k-alexandra/WMATA.swift.git", 
        .upToNextMajor(from: "15.0.0")
    )
]
```

## Usage

### Standard API

To work with WMATA's Standard API use the `WMATA` package.

```swift
import WMATA

let nextTrains = Rail.NextRails(
    key: YOUR_API_KEY,
    station: .waterfront
)

nextTrains.request { result in 
    switch result {
    case let .success(response):
        print(response.trains)
    case let .failure(error):
        print(error)
    }
}
```

### GTFS Static

To work with GTFS Static data use the `MetroGTFS` package.

```swift
import MetroGTFS

let ashburn = try GTFSStop("STN_N12")

print(ashburn.name) // "ASHBURN METRORAIL STATION"
```

## OS Support

WMATA.swift commits to supporting current minus 2 OS versions.

Currently, WMATA.swift is compatible with macOS 12, iOS 15, tvOS 15, watchOS 8 or higher.

## Documentation

Full documentation is available at <https://emma-k-alexandra.github.io/WMATA.swift/documentation/wmata/> or within Xcode.

To view documentation within Xcode, within the menu navigate to `Product > Build Documentation`. WMATA's documentation will appear under `Workspace Documentation` within the Developer Documentation window. Navigate to `Window > Developer Documentation` to open this window.

## Dependencies

- [swift-protobuf](https://github.com/apple/swift-protobuf), for GTFS-RT feeds.
- [DVR](https://github.com/venmo/DVR), for testing.
- [SQLite.swift](https://github.com/stephencelis/SQLite.swift), for GTFS Static data. Only used in `MetroGTFS` package.

## Contact

Feel free to email questions and comments to [emma@emma.sh](mailto:emma@emma.sh)

## Contributing

Todo:

- [ ] Support all GTFS Static data in `MetroGTFS`
- [ ] Convert async functions from a `Result` to `return` or `throw` behavior, the dominant async pattern in Swift

## Developer

To generate documentation for deploying to Github Pages, run `./docs.sh`.

## License

WMATA.swift is released under the MIT license. [See LICENSE](https://github.com/emma-k-alexandra/WMATA.swift/blob/main/LICENSE) for details.

This package is not distributed by or affiliated with WMATA.
