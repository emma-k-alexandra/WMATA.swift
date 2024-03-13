# ``MetroGTFS``

A Swift interface to WMATA's GTFS Static data.

## Quickstart

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
