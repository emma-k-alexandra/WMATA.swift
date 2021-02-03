### Using `Station`

The `Station` enum provides a lot of additional information for stations that you can use without having to make network requests.

#### `name`

```swift
let name = Station.A01.name // "Metro Center"
```

`name` provides an easy way to get a human readable and presentable string of the station's name.

#### `lines`

```swift
let lines = Station.A01.lines // [.BL, .OR, .SV, .RD]
```

`lines` provides the `Line`s a station is on without making a network request.

#### `openingTime(:)`

```swift
let openingTime = Station.A01.openingTime() // ("2020-01-12 08:14:00 +0000")
```

`openingTime` provides the opening time of a station without making a network request. Note: This is only accurate generally, not on event days. For guaranteed accurate information use the `timings` method on a `Station` or `MetroRail`.
