# Using `MetroBus`

`MetroBus` provides access to all Metro Bus APIs. Calls can be handled by callback, delegate or Combine Publisher depending on your needs.

## Callback methods
These methods access the WMATA API and return your result via a callback. If you can't use Combine, or don't need background requests, these methods are ideal for you.

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

### `alerts`

[Google Documentation][alerts] 
GTFS RT 2.0 alerts feed for MetroBus

```swift
MetroBus(key: apiKey).alerts() { result in
    switch result {
    case .success(let alerts):
        print(alerts)

    case .failure(let error):
        print(error)
    }
}  
```

### `tripUpdates`

[Google Documentation][trip-updates] 
GTFS RT 2.0 trip updates feed for MetroBus

```swift
MetroBus(key: apiKey).tripUpdates() { result in
    switch result {
    case .success(let tripUpdates):
        print(alerts)

    case .failure(let error):
        print(error)
    }
}  
```

### `vehiclePositions`

[Google Documentation][vehicle-positions] 
GTFS RT 2.0 trip updates feed for MetroBus

```swift
MetroBus(key: apiKey).vehiclePositions() { result in
    switch result {
    case .success(let vehiclePositions):
        print(vehiclePositions)

    case .failure(let error):
        print(error)
    }
}  
```

## Delegate methods

These methods are for use with a `WMATADelegate`. For information on creating your own implementation of the `WMATADelegate` protocol, check the [Background Requests][background-docs] documentation.

### `routes`

[WMATA Documentation][routes]
All bus routes

```swift
MetroBus(key: apiKey, delegate: SomeDelegate()).routes()
```

### `searchStops`

[WMATA Documentation][search-stops]  
Stops near a given latlong and within a given radius. Omit all parameters to receive all stops.

```swift
let location = RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))

MetroBus(key: apiKey, delegate: SomeDelegate()).searchStops(at: location)
```

### `positions`

[WMATA Documentation][positions]  
Bus positions along a route (optional), at a latlong and within a radius (in meters)

```swift
let location = RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))

MetroBus(key: apiKey, delegate: SomeDelegate()).positions(on: "10A", at: location)
```

### `incidents`

[WMATA Documentation][incidents]  
MetroBus incidents along an optional route.

```swift
MetroBus(key: apiKey, delegate: SomeDelegate()).incidents(on: "10A")
```

### `pathDetails`

[WMATA Documentation][path-details]  
Ordered latlong points along this Route for a given date. Omit for today.

```swift
MetroBus(key: apiKey, delegate: SomeDelegate()).pathDetails(for: "10A")
```

### `routeSchedule`

[WMATA Documentation][route-schedule]  
Scheduled stops for this Route

```swift
MetroBus(key: apiKey, delegate: SomeDelegate()).routeSchedule(for: "10A")
```

### `nextBuses`

[WMATA Documentation][next-buses]  
Next bus arrivals at this Stop

```swift
MetroBus(key: apiKey, delegate: SomeDelegate()).nextBuses(for: "1001195")
```

### `stopSchedule`

[WMATA Documentation][stop-schedule]  
Buses scheduled to arrival at this Stop at a given date. Omit for today.

```swift
MetroBus(key: apiKey, delegate: SomeDelegate()).stopSchedule(for: "1001195")
```

### `alerts`

[Google Documentation][alerts] 
GTFS RT 2.0 alerts feed for MetroBus

```swift
MetroBus(key: apiKey, delegate: SomeDelegate()).alerts()
```

### `tripUpdates`

[Google Documentation][trip-updates] 
GTFS RT 2.0 trip updates feed for MetroBus

```swift
MetroBus(key: apiKey, delegate: SomeDelegate()).tripUpdates() 
```

### `vehiclePositions`

[Google Documentation][vehicle-positions] 
GTFS RT 2.0 trip updates feed for MetroBus

```swift
MetroBus(key: apiKey, delegate: SomeDelegate()).vehiclePositions()
```

## Combine Publisher methods
These methods access the WMATA API and return your result via a Combine [`Publisher`][publisher]. In modern projects, these methods should be your goto. Combine Publishers can't be used in the background. For more details on using Combine with WMATA.swift, check the [Combine][combine-docs] documentation.

### `routesPublisher`

[WMATA Documentation][routes]
All bus routes

```swift
let cancellable = MetroBus(key: apiKey)
    .routesPublisher()
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

### `searchStopsPublisher`

[WMATA Documentation][search-stops]  
Stops near a given latlong and within a given radius. Omit all parameters to receive all stops.

```swift
let location = RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))

let cancellable =  MetroBus(key: apiKey)
    .searchStopsPublisher(at: location)
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

### `positionsPublisher`

[WMATA Documentation][positions]  
Bus positions along a route (optional), at a latlong and within a radius (in meters)

```swift
let location = RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))

let cancellable = MetroBus(key: apiKey)
    .positionsPublisher(on: "10A", at: location)
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
let cancellable = MetroBus(key: apiKey)
    .incidentsPublisher(on: "10A")
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
let cancellable = MetroBus(key: apiKey)
    .pathDetailsPublisher(for: "10A")
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

### `routeSchedulePublisher`

[WMATA Documentation][route-schedule]  
Scheduled stops for this Route

```swift
let cancellable = MetroBus(key: apiKey)
    .routeSchedulePublisher(for: "10A")
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

### `nextBusesPublisher`

[WMATA Documentation][next-buses]  
Next bus arrivals at this Stop

```swift
let cancellable = MetroBus(key: apiKey)
    .nextBusesPublisher(for: "1001195")
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

### `stopSchedulePublisher`

[WMATA Documentation][stop-schedule]  
Buses scheduled to arrival at this Stop at a given date. Omit for today.

```swift
let cancellable = MetroBus(key: apiKey)
    .stopSchedulePublisher(for: "1001195")
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

### `alertsPublisher`

[Google Documentation][alerts] 
GTFS RT 2.0 alerts feed for MetroBus

```swift
let cancellable = MetroBus(key: apiKey)
    .alertsPublisher()
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

### `tripUpdatesPublisher`

[Google Documentation][trip-updates] 
GTFS RT 2.0 trip updates feed for MetroBus

```swift
let cancellable = MetroBus(key: apiKey)
    .tripUpdatesPublisher()
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

### `vehiclePositionsPublisher`

[Google Documentation][vehicle-positions] 
GTFS RT 2.0 trip updates feed for MetroBus

```swift
let cancellable = MetroBus(key: apiKey)
    .vehiclePositionsPublisher() 
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

[positions]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68
[routes]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6a
[search-stops]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6d
[incidents]: https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d75
[positions]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68
[path-details]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d69
[route-schedule]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6b
[next-buses]: https://developer.wmata.com/docs/services/5476365e031f590f38092508/operations/5476365e031f5909e4fe331d
[stop-schedule]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6c
[combine-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Combine.md
[publisher]: https://developer.apple.com/documentation/combine/publisher
[background-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Background.md
[alerts]: https://developers.google.com/transit/gtfs-realtime/guides/service-alerts
[trip-updates]: https://developers.google.com/transit/gtfs-realtime/guides/trip-updates
[vehicle-positions]: https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions
