# ``MetroGTFS``

A Swift interface to WMATA's GTFS Static data.

## Install

### Swift Package Manager

If adding MetroGTFS to a Swift Package, add 

```swift
dependencies: [
    .package(
        name: "WMATA",
        url: "https://github.com/emma-k-alexandra/WMATA.swift.git", 
        .upToNextMajor(from: "15.0.0")
    )
]
```

### Xcode

Add `https://github.com/emma-k-alexandra/WMATA.swift.git` to your project's Package Dependencies. Select `Up to Next Major Version` and set the version to `15.0.0`

## Usage

In your code, add

```swift
import MetroGTFS

let ashburn = try GTFSStop("STN_N12")

print(ashburn.name) // "ASHBURN METRORAIL STATION"
```

## Structures

- ``GTFSStop``
- ``GTFSLevel``

## Utilities

- ``GTFSIdentifier``
