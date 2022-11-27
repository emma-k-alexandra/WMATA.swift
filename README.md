# WMATA.swift

WMATA.swift is a Swift interface to the [Washington Metropolitan Area Transit Authority API](https://developer.wmata.com).

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Documentation](#documentation)
- [Dependencies](#dependencies)
- [Contact](#contact)
- [Contributing](#contributing)
- [License](#license)

## Installation

### Requirements

- Swift 5.6
- Xcode 13.2

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

## OS Support

WMATA.swift commits to supporting current minus 2 OS versions.

Currently, WMATA.swift is compatible with macOS 10.15, iOS 13, tvOS 13, watchOS 6 or higher.

## Documentation

Full documentation is available at <https://emma-k-alexandra.github.io/WMATA.swift/documentation/wmata/> or within Xcode.

To view documentation within Xcode, within the menu navigate to `Product > Build Documentation`. WMATA's documentation will appear under `Workspace Documentation` within the Developer Documentation window. Navigate to `Window > Developer Documentation` to open this window.

## Dependencies

- [swift-protobuf](https://github.com/apple/swift-protobuf), for GTFS-RT feeds.
- [DVR](https://github.com/venmo/DVR), for testing.

## Contact

Feel free to email questions and comments to [emma@emma.sh](mailto:emma@emma.sh)

## Contributing

Todo:

- [ ] Build out more DVR tests.
- [ ] Automated builds.
- [ ] Convert async functions from a `Result` to `return` or `throw` behavior, the dominant async pattern in Swift.

## Developer

To generate documentation for deploying to Github Pages, run `./docs.sh`.

## License

WMATA.swift is released under the MIT license. [See LICENSE](https://github.com/emma-k-alexandra/WMATA.swift/blob/main/LICENSE) for details.
