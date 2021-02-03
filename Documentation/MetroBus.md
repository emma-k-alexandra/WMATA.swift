# Using `MetroBus`

`MetroBus` provides access to all Metro Bus APIs. Calls can be handled by callback, delegate or Combine Publisher depending on your needs.

## Callback methods
These methods access the WMATA API and return your result via a callback. If you can't use Combine, or don't need background requests, these methods are ideal for you.

### `positions`

[WMATA Documentation][positions]  
Bus positions along a route (optional), at a latlong and within a radius (in meters)

```swift
let location = RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))

MetroBus(key: apiKey).positions(on: "10A", at: location) { result in
    switch result {
    case .success(let positions):
        print(positions)

    case .failure(let error):
        print(error)
    }
}
```

### `routes`

[WMATA Documentation][routes]
All bus routes

```swift
MetroBus(key: apiKey).routes { result in
    switch result {
    case .success(let routes):
        print(routes)

    case .failure(let error):
        print(error)
    }
}
```

### `searchStops`

[WMATA Documentation][search-stops]  
Stops near a given latlong and within a given radius. Omit all parameters to receive all stops.

```swift
let location = RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))

MetroBus(key: apiKey).searchStops(at: location) { result in
    switch result {
    case .success(let stops):
        print(stops)

    case .failure(let error):
        print(error)
    }
}
```

### `incidents`

[WMATA Documentation][incidents]  
MetroBus incidents along an optional route.

```swift
MetroBus(key: apiKey).incidents(on: "10A") { result in
    switch result {
    case .success(let incidents):
        print(incidents)

    case .failure(let error):
        print(error)
    }
}
```

### `positions`

[WMATA Documentation][positions]  
Bus positions along this route, within an optional latlong and radius (in meters).

```swift
let location = RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))
MetroBus(key: apiKey).positions(at: "10A", at: location) { result in
    switch result {
    case .success(let positions):
        print(positions)

    case .failure(let error):
        print(error)
    }
}
```

### `pathDetails`

[WMATA Documentation][path-details]  
Ordered latlong points along this Route for a given date. Omit for today.

```swift
MetroBus(key: apiKey).pathDetails(for: "10A") { result in
    switch result {
    case .success(let path):
        print(path)

    case .failure(let error):
        print(error)
    }
}
```

### `routeSchedule`

[WMATA Documentation][route-schedule]  
Scheduled stops for this Route

```swift
MetroBus(key: apiKey).routeSchedule(for: "10A") { result in
    switch result {
    case .success(let schedule):
        print(schedule)

    case .failure(let error):
        print(error)
    }
}
```

### `nextBuses`

[WMATA Documentation][next-buses]  
Next bus arrivals at this Stop

```swift
MetroBus(key: apiKey).nextBuses(for: "1001195") { result in
    switch result {
    case .success(let predictions):
        print(predictions)

    case .failure(let error):
        print(error)
    }
}
```

### `stopSchedule`

[WMATA Documentation][stop-schedule]  
Buses scheduled to arrival at this Stop at a given date. Omit for today.

```swift
MetroBus(key: apiKey).stopSchedule(for: "1001195") { result in
    switch result {
    case .success(let schedule):
        print(schedule)

    case .failure(let error):
        print(error)
    }
}
```

[positions]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68
[routes]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6a
[search-stops]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6d
[incidents]: https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d75
[positions]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68
[path-details]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d69
[route-schedule]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6b
[next-buses]: https://developer.wmata.com/docs/services/5476365e031f590f38092508/operations/5476365e031f5909e4fe331d
[stop-schedule]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6c
