- [`RadiusAtCoordinates`](#RadiusAtCoordinates)
- [`WMATADate`](#WMATADate)

#  `RadiusAtCoordinates`

Some WMATA APIs ask you to define a location and radius, you can use this struct to define those locations.

## Definition
```swift
public struct RadiusAtCoordinates {
    public let radius: UInt
    public let coordinates: Coordinates
}

public struct Coordinates {
    public let latitude: Double
    public let longitude: Double
}
```

## Units

`radius` is defined in meters
`latitude` is defined in degrees, positive
`longitude` is defined in degrees, negative

## Convenience init

You can avoid initializing a `Coordinates` struct with a convenience initializer

```swift
let location = RadiusAtCoordinates(radius: 1000, latitude: 38.8817596, longitude: -77.0166426)
```

# `WMATADate`

Some WMATA APIs ask you for a date, you can use this struct to define a Date that WMATA will understand.

## Definition
```swift
public struct WMATADate {
    public let year: Int
    public let month: Int
    public let day: Int
}
```

## Timezone

Provided dates should be in Eastern time.
