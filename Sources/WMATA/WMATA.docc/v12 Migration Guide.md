# v12 Migration Guide

WMATA.swift v12 removes the need to use `StationSet` when making calls to ``Rail/NextTrains``.

## Breaking changes

- Removed `Rail.NextTrains.StationSet`.

This part of the package now works more similarly to the rest of the package.

If you wish to make a request for trains at all Metrorail stations, omit the `stations` parameter when using ``Rail/NextTrains/init(key:stations:delegate:)``. Example:

```swift
let nextTrains = Rail.NextTrains(key: API_KEY)
```

If you wish wish to make a request for multiple stations, pass an array of stations to ``Rail/NextTrains/init(key:stations:delegate:)``

```swift
let nextTrains = Rail.NextTrains(key: API_KEY, stations: [.waterfront, .navyYard])
let nextTrains = Rail.NextTrains(key: API_KEY, stations: .fortTotten) // Call for both stations at Fort Totten
```

- Moved `Rail.NextTrains.StationSet.lenfantPlaza` to `Array.lenfantPlaza`
- Moved `Rail.NextTrains.StationSet.metroCenter` to `Array.metroCenter`
- Moved `Rail.NextTrains.StationSet.fortTotten` to `Array.fortTotten`
- Moved `Rail.NextTrains.StationSet.galleryPlace` to `Array.galleryPlace`
