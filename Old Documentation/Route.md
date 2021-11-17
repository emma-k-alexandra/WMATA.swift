#  Using `Route`

The `Route` struct represents a MetroBus route.

## Definition

```swift
public struct Route {
    public let id: String
}
```

Values are `RouteID`s rather than route names.

### Values
MetroBus stops are numerous and defining them all explicitly is not feasible. Check the [Routes][stop-search] API from WMATA, which is available on `MetroBus` as the `routes` method.

### As a `String`

When explicitly stating a `Route`, you can simply provide a `String` of the RouteID you wish to use, rather than creating a `Route` struct explicitly.

```swift
let route: Route = "10A"
```

You'll still need to use the `id` field when you are provided a `Route` instance.

## Callback methods

### `positions`

[WMATA Documentation][positions]  
Bus positions along this route, within an optional latlong and radius (in meters).

```swift
let location = RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))

Route(id: "10A").positions(at: location, key: apiKey) { result in
    switch result {
    case .success(let positions):
        print(positions)

    case .failure(let error):
        print(error)
    }
}
```

### `incidents`

[WMATA Documentation][incidents]  
MetroBus incidents along an optional route.

```swift
Route(id: "10A").incidents(key: apiKey) { result in
    switch result {
    case .success(let incidents):
        print(incidents)

    case .failure(let error):
        print(error)
    }
}
```

### `pathDetails`

[WMATA Documentation][path-details]  
Ordered latlong points along this Route for a given date. Omit for today.

```swift
Route(id: "10A").pathDetails(key: apiKey) { result in
    switch result {
    case .success(let path):
        print(path)

    case .failure(let error):
        print(error)
    }
}
```

### `schedule`

[WMATA Documentation][route-schedule]  
Scheduled stops for this Route

```swift
Route(id: "10A").routeSchedule(key: apiKey { result in
    switch result {
    case .success(let schedule):
        print(schedule)

    case .failure(let error):
        print(error)
    }
}
```

## Combine Publisher methods
These methods access the WMATA API and return your result via a Combine [`Publisher`][publisher]. In modern projects, these methods should be your goto. Combine Publishers can't be used in the background. For more details on using Combine with WMATA.swift, check the [Combine][combine-docs] documentation.

### `positionsPublisher`

[WMATA Documentation][positions]  
Bus positions along this route, within an optional latlong and radius (in meters).

```swift
let location = RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))

Route(id: "10A")
    .positionsPublisher(at: location, key: apiKey)
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Finished")
            case let .failure(failure):
                print(failure)
            }
        },
        receiveValue: { response in
            print(response)
        }
    )
```

### `incidentsPublisher`

[WMATA Documentation][incidents]  
MetroBus incidents along an optional route.

```swift
Route(id: "10A")
    .incidentsPublisher(key: apiKey)
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Finished")
            case let .failure(failure):
                print(failure)
            }
        },
        receiveValue: { response in
            print(response)
        }
    )
```

### `pathDetailsPublisher`

[WMATA Documentation][path-details]  
Ordered latlong points along this Route for a given date. Omit for today.

```swift
Route(id: "10A")
    .pathDetailsPublisher(key: apiKey)
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Finished")
            case let .failure(failure):
                print(failure)
            }
        },
        receiveValue: { response in
            print(response)
        }
    )
```

### `schedulePublisher`

[WMATA Documentation][route-schedule]  
Scheduled stops for this Route

```swift
Route(id: "10A")
    .schedulePublisher(key: apiKey)
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Finished")
            case let .failure(failure):
                print(failure)
            }
        },
        receiveValue: { response in
            print(response)
        }
    )
```

[stop-search]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6a
[positions]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68
[incidents]: https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d75
[path-details]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d69
[route-schedule]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6b
[combine-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Combine.md
[publisher]: https://developer.apple.com/documentation/combine/publisher
