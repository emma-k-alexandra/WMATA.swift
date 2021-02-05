# WMATA.swift

WMATA.swift is a Swift interface to the [Washington Metropolitan Area Transit Authority API](https://developer.wmata.com).

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- Usage
  - [Introduction][intro-docs]
  - [`MetroRail`][metro-rail-docs]
    - [`Station`][station-docs], [`Line`][line-docs]
  - [`MetroBus`][metro-bus-docs]
    - [`Stop`][stop-docs], [`Route`][route-docs]
- Advanced Usage
  - [Combine][combine-docs]
  - [Background Requests][background-docs]
- Miscellaneous
  - [`RadiusAtCoordinates`][radius-at-coordinates]
  - [WMATADate][wmata-date]
- [Dependencies](#dependencies)
- [Testing](#testing)
- [Contact](#contact)
- [Contributing](#contributing)
- [License](#license)

## Requirements

- Swift 5.1+

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/emma-k-alexandra/WMATA.swift.git", .upToNextMajor(from: "9.0.0"))
]
```

## Dependencies

- [swift-protobuf](https://github.com/apple/swift-protobuf), for GTFS-RT feeds.

## Testing

Tests may fail due to rate limits on the WMATA API. Failed tests must be retried manually.

## Contact

Feel free to email questions and comments to [emma@emma.sh](mailto:emma@emma.sh)

## Contributing

Todo:

- [ ] Last Train times (API doesn't provide full information here)
- [ ] Documentation of response structs a la [wmata](https://github.com/emma-k-alexandra/wmata)
- [ ] Figure out how to serialize tests
- [ ] Automated builds
- [ ] Possible support for CocoaPods/Carthage?

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
[wmata-date]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Miscellaneous.md#WMATADate
