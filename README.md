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

## Requirements

- Swift 5.6
- Xcode 13.2

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(
        name: "WMATA",
        url: "https://github.com/emma-k-alexandra/WMATA.swift.git", 
        .upToNextMajor(from: "14.0.0")
    )
]
```

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

- [ ] Build out more DVR tests
- [ ] Last Train times (API doesn't provide full information here)
- [ ] Automated builds

## Developer

To generate documentation for deploying to Github Pages, run `./docs.sh`.

## License

WMATA.swift is released under the MIT license. [See LICENSE](https://github.com/emma-k-alexandra/WMATA.swift/blob/main/LICENSE) for details.
