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

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/emma-k-alexandra/WMATA.swift.git", .upToNextMajor(from: "11.0.0"))
]
```

## Documentation

Full documentation is available within Xcode, or [on the web in a slightly broken form](https://github.com/emma-k-alexandra/WMATA.swift/blob/main/Sources/WMATA/WMATA.docc/Documentation.md). Thanks DocC!

## Dependencies

- [GTFS][gtfs]
- [swift-protobuf][swift-protobuf], for GTFS-RT feeds.

## Contact

Feel free to email questions and comments to [emma@emma.sh](mailto:emma@emma.sh)

## Contributing

Todo:

- [ ] Improve GTFS support with better decoding 
- [ ] Last Train times (API doesn't provide full information here)
- [ ] Automated builds

## License

WMATA.swift is released under the MIT license. [See LICENSE](https://github.com/emma-k-alexandra/WMATA.swift/blob/master/LICENSE) for details.

[intro-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Introduction.md
[metro-rail-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/MetroRail.md
[station-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Station.md
[line-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Line.md
[metro-bus-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/MetroBus.md
[stop-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Stop.md
[route-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Route.md
[combine-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Combine.md
[background-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Background.md
[radius-at-coordinates]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Miscellaneous.md#RadiusAtCoordinates
[v9-migration-guide]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/v9%20Migration%20Guide.md
[v10-migration-guide]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/v10%20Migration%20Guide.md
[gtfs]: https://github.com/emma-k-alexandra/GTFS
[swift-protobuf]: https://github.com/apple/swift-protobuf
[wmata]: https://developer.wmata.com
[wmata-rust]: https://github.com/emma-k-alexandra/wmata
