# ``MetroGTFS``

A Swift interface to WMATA's GTFS Static data.

## Quickstart

```swift
import MetroGTFS

let stop = try GTFS.Stop("STN_N12")

print(stop.name) // "ASHBURN METRORAIL STATION"
```

## Structures

- ``GTFSStop``
- ``GTFSLevel``

## Utilities

- ``GTFSIdentifier``
