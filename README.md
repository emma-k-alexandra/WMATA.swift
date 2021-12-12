# WMATA.swift

WMATA.swift is a Swift interface to the [Washington Metropolitan Area Transit Authority API][wmata].

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Documentation](#documentation)
- [Dependencies](#dependencies)
- [Contact](#contact)
- [Contributing](#contributing)
- [License](#license)

## Requirements

- Swift 5.5
- Xcode 13.2

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(
        name: "WMATA",
        url: "https://github.com/emma-k-alexandra/WMATA.swift.git", 
        .upToNextMajor(from: "11.0.0")
    )
]
```

## Documentation

Full documentation is available within Xcode, or [on the web in a slightly broken form](https://github.com/emma-k-alexandra/WMATA.swift/blob/main/Sources/WMATA/WMATA.docc/Documentation.md). Thanks DocC!

## Dependencies

- [GTFS][gtfs]
- [swift-protobuf][swift-protobuf], for GTFS-RT feeds.
- [DVR](https://github.com/venmo/DVR), for testing.

## Contact

Feel free to email questions and comments to [emma@emma.sh](mailto:emma@emma.sh)

## Contributing

Todo:

- [ ] Improve GTFS support with better decoding 
- [ ] Last Train times (API doesn't provide full information here)
- [ ] Automated builds

## License

WMATA.swift is released under the MIT license. [See LICENSE](https://github.com/emma-k-alexandra/WMATA.swift/blob/master/LICENSE) for details.

[gtfs]: https://github.com/emma-k-alexandra/GTFS
[swift-protobuf]: https://github.com/apple/swift-protobuf
[wmata]: https://developer.wmata.com
