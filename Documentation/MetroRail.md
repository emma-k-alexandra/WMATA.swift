# Using `MetroRail`

`MetroRail` provides access to all Metro Rail APIs. Calls can be handled by callback, delegate or Combine Publisher depending on your needs.

## Callback Methods
These methods access the WMATA API and return your result via a callback. If you can't use Combine, or don't need background requests, these methods are ideal for you.

### `lines`

 [WMATA Documentation][lines]  
 Returns basic information on all MetroRail lines.

```swift
MetroRail(key: apiKey).lines { result in
    switch result {
    case let .success(lines):
        print(lines)

    case let .failure(error):
        print(error)
    }
}
```

### `entrances`

[WMATA Documentation][entrances]  
Station entrances within a latlong pair and radius (in meters). Omit all parameters to receive all entrances.

```swift
let location = RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))

MetroRail(key: apiKey).entrances(at: location) { result in
    switch result {
    case let .success(entrances):
        print(entrances)

    case let .failure(error):
        print(error)
    }
}
```

### `stations`

[WMATA Documentation][stations]  
Stations along a Line (optional)

```swift
MetroRail(key: apiKey).stations(for: .BL) { result in
    switch result {
    case let .success(stations):
        print(stations)

    case let .failure(error):
        print(error)
    }
}
```

### `station`

[WMATA Documentation][station]
Distance, fare information and estimated travel time between two stations. Omit both station codes for all possible trips.

```swift
MetroRail(key: apiKey).station(.A01, to: .A02) { result in 
    switch result {
    case let .success(travelInfo):
        print(travelInfo)

    case let .failure(error):
        print(error)
    }
}
```

### `positions`

[WMATA Documentation][positions]  
Uniquely identifiable trains in service and what track circuits they currently occupy

```swift
MetroRail(key: apiKey).positions { result in
    switch result {
    case let .success(positions):
        print(positions)

    case let .failure(error):
        print(error)
    }
}
```

### `routes`

[WMATA Documentation][routes]
Ordered list of track circuits, arranged by line and track number

```swift
MetroRail(key: apiKey).routes { result in 
    switch result {
    case let .success(routes):
        print(routes)

    case let .failure(error):
        print(error)
    }
}
```

### `circuits`

[WMATA Documentation][circuits]
List of all track circuits - also see [Train Positions FAQ][trains-positions-faq]

```swift
MetroRail(key: apiKey).circuits { result in 
    switch result {
    case let .success(circuits):
        print(circuits)

    case let .failure(error):
        print(error)
    }
}
```

### `elevatorAndEscalatorIncidents`

[WMATA Documentation][elevator-and-escalator-incidents]  
Reported elevator and escalator incidents

```swift
MetroRail(key: apiKey).elevatorAndEscalatorIncidents(at: .A01) { result in
    switch result {
    case let .success(incidents):
        print(incidents)

    case let .failure(error):
        print(error)
    }
}
```

### `incidents`

[WMATA Documentation][incidents]  
Reported MetroRail incidents at a particular station (optional)

```swift
MetroRail(key: apiKey).incidents(at: .A01) { result in
    switch result {
    case let .success(incidents):
        print(incidents)

    case let .failure(error):
        print(error)
    }
}
```

### `nextTrains`

  [WMATA Documentation][next-trains]  
  Next train arrivals for this station.

```swift
MetroRail(key: apiKey).nextTrains(at: .A01) { result in
    switch result {
    case let .success(predictions):
        print(predictions)

    case let .failure(error):
        print(error)
    }
}
```

### `nextTrains` (multiple)

  [WMATA Documentation][next-trains]
  Next train arrivals for this station.

```swift
MetroRail(key: apiKey).nextTrains(at: [.A01, .C01]) { result in
    switch result {
    case let .success(predictions):
        print(predictions)

    case let .failure(error):
        print(error)
    }
}
```

### `information`

  [WMATA Documentation][information]  
  Location and address information for this station.

```swift
MetroRail(key: apiKey).information(for: .A01) { result in
    switch result {
    case let .success(information):
        print(information)

    case let .failure(error):
        print(error)
    }
}
```

### `parkingInformation`

[WMATA Documentation][parking-information]  
Parking information for this station.

```swift
MetroRail(key: apiKey).parkingInformation(for: .A01) { result in
    switch result {
    case let .success(parkingInfo):
        print(parkingInfo)

    case let .failure(error):
        print(error)
    }
}
```

### `path`

[WMATA Documentation][path]  
Returns a set of ordered stations and distances between stations *on the same line*

```swift
MetroRail(key: apiKey).path(from: .A01 to: .A02) { result in
    switch result {
    case let .success(path):
        print(path)

    case let .failure(error):
        print(error)
    }
}
```

### `timings`

[WMATA Documentation][timings]  
Opening times and scheduled first and last trains for this station

```swift
MetroRail(key: apiKey).timings(for: .A01) { result in
    switch result {
    case let .success(timings):
        print(timings)

    case let .failure(error):
        print(error)
    }
}
```

### `alerts`

[Google Documentation][alerts] 
GTFS RT 2.0 alerts feed for MetroRail

```swift
MetroRail(key: apiKey).alerts() { result in
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
GTFS RT 2.0 trip updates feed for MetroRail

```swift
MetroRail(key: apiKey).tripUpdates() { result in
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
GTFS RT 2.0 trip updates feed for MetroRail

```swift
MetroRail(key: apiKey).vehiclePositions() { result in
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

### `lines`

 [WMATA Documentation][lines]  
 Returns basic information on all MetroRail lines.

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).lines()
```

### `entrances`

[WMATA Documentation][entrances]
Station entrances within a latlong pair and radius (in meters). Omit all parameters to receive all entrances.

```swift
let location = RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))

MetroRail(key: apiKey, delegate: SomeDelegate()).entrances(at: location)
```

### `stations`

[WMATA Documentation][stations]
Stations along a Line (optional)

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).stations(for: .BL)
```

### `station`

[WMATA Documentation][station]
Distance, fare information and estimated travel time between two stations. Omit both station codes for all possible trips.

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).station(.A01, to: .A02)
```

### `positions`

[WMATA Documentation][positions]
Uniquely identifiable trains in service and what track circuits they currently occupy

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).positions()
```

### `routes`

[WMATA Documentation][routes]
Ordered list of track circuits, arranged by line and track number

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).routes()
```

### `circuits`

[WMATA Documentation][circuits]
List of all track circuits - also see [Train Positions FAQ][train-positions-faq]

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).circuits()
```

### `elevatorAndEscalatorIncidents`

[WMATA Documentation][elevator-and-escalator-incidents]
Reported elevator and escalator incidents

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).elevatorAndEscalatorIncidents(at: .A01)
```

### `incidents`

[WMATA Documentation][incidents]
Reported MetroRail incidents at a particular station (optional)

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).incidents(at: .A01)
```

### `nextTrains`

  [WMATA Documentation][next-trains]
  Next train arrivals for this station.

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).nextTrains(at: .A01)
```

### `nextTrains` (multiple)

  [WMATA Documentation][next-trains]
  Next train arrivals for this station.

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).nextTrains(at: [.A01, .C01])
```

### `information`

  [WMATA Documentation][information]
  Location and address information for this station.

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).information(for: .A01)
```

### `parkingInformation`

[WMATA Documentation][parking-information]
Parking information for this station.

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).parkingInformation(for: .A01)
```

### `path`

[WMATA Documentation][path]
Returns a set of ordered stations and distances between stations *on the same line*

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).path(from: .A01 to: .A02)
```

### `timings`

[WMATA Documentation][timings]
Opening times and scheduled first and last trains for this station

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).timings(for: .A01)
```

### `alerts`

[Google Documentation][alerts] 
GTFS RT 2.0 alerts feed for MetroRail

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).alerts()
```

### `tripUpdates`

[Google Documentation][trip-updates] 
GTFS RT 2.0 trip updates feed for MetroRail

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).tripUpdates() 
```

### `vehiclePositions`

[Google Documentation][vehicle-positions] 
GTFS RT 2.0 trip updates feed for RAILBus

```swift
MetroRail(key: apiKey, delegate: SomeDelegate()).vehiclePositions()
```

## Combine Publisher methods
These methods access the WMATA API and return your result via a Combine [`Publisher`][publisher]. In modern projects, these methods should be your goto. Combine Publishers can't be used in the background. For more details on using Combine with WMATA.swift, check the [Combine][combine-docs] documentation.

### `linesPublisher`

 [WMATA Documentation][lines]  
 Returns basic information on all MetroRail lines.

```swift
let cancellable = MetroRail(key: apiKey)
    .linesPublisher()
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

### `entrancesPublisher`

[WMATA Documentation][entrances]
Station entrances within a latlong pair and radius (in meters). Omit all parameters to receive all entrances.

```swift
let location = RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))

let cancellable = MetroRail(key: apiKey)
    .entrancesPublisher(at: location)
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

### `stationsPublisher`

[WMATA Documentation][stations]
Stations along a Line (optional)

```swift
let cancellable = MetroRail(key: apiKey)
    .stationsPublisher(for: .BL)
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

### `stationPublisher`

[WMATA Documentation][station]
Distance, fare information and estimated travel time between two stations. Omit both station codes for all possible trips.

```swift
let cancellable = MetroRail(key: apiKey)
    .stationPublisher(.A01, to: .A02)
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
Uniquely identifiable trains in service and what track circuits they currently occupy

```swift
let cancellable = MetroRail(key: apiKey)
    .positionsPublisher()
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

### `routesPublisher`

[WMATA Documentation][routes]
Ordered list of track circuits, arranged by line and track number

```swift
let cancellable = MetroRail(key: apiKey)
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

### `circuitsPublisher`

[WMATA Documentation][circuits]
List of all track circuits - also see [Train Positions FAQ][train-positions-faq]

```swift
let cancellable = MetroRail(key: apiKey)
    .circuitsPublisher()
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

### `elevatorAndEscalatorIncidentsPublisher`

[WMATA Documentation][elevator-and-escalator-incidents]
Reported elevator and escalator incidents

```swift
let cancellable = MetroRail(key: apiKey)
    .elevatorAndEscalatorIncidentsPublisher(at: .A01)
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
Reported MetroRail incidents at a particular station (optional)

```swift
let cancellable = MetroRail(key: apiKey)
    .incidentsPublisher(at: .A01)
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

### `nextTrainsPublisher`

  [WMATA Documentation][next-trains]
  Next train arrivals for this station.

```swift
let cancellable = MetroRail(key: apiKey)
    .nextTrainsPublisher(at: .A01)
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

### `nextTrainsPublisher` (multiple)

  [WMATA Documentation][next-trains]
  Next train arrivals for this station.

```swift
let cancellable = MetroRail(key: apiKey)
    .nextTrainsPublisher(at: [.A01, .C01])
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

### `informationPublisher`

  [WMATA Documentation][information]
  Location and address information for this station.

```swift
let cancellable = MetroRail(key: apiKey)
    .informationPublisher(for: .A01)
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

### `parkingInformationPublisher`

[WMATA Documentation][parking-information]  
Parking information for this station.

```swift
let cancellable = MetroRail(key: apiKey)
    .parkingInformationPublisher(for: .A01)
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

### `pathPublisher`

[WMATA Documentation][path]
Returns a set of ordered stations and distances between stations *on the same line*

```swift
let cancellable = MetroRail(key: apiKey)
    .pathPublisher(from: .A01 to: .A02)
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

### `timingsPublisher`

[WMATA Documentation][timings]
Opening times and scheduled first and last trains for this station

```swift
let cancellable = MetroRail(key: apiKey)
    .timingsPublisher(for: .A01)
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
GTFS RT 2.0 alerts feed for MetroRail

```swift
let cancellable = MetroRail(key: apiKey)
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
GTFS RT 2.0 trip updates feed for MetroRail

```swift
let cancellable = MetroRail(key: apiKey)
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
GTFS RT 2.0 trip updates feed for MetroRail

```swift
let cancellable = MetroRail(key: apiKey)
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

[background-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Background.md
[combine-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Combine.md
[publisher]: https://developer.apple.com/documentation/combine/publisher
[lines]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330c
[entrances]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330f
[stations]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311
[station]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3313
[positions]: https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/5763fb35f91823096cac1058
[routes]: https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57641afc031f59363c586dca
[circuits]: https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57644238031f59363c586dcb
[elevator-and-escalator-incidents]: https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d76
[incidents]: https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d77
[next-trains]: https://developer.wmata.com/docs/services/547636a6f9182302184cda78/operations/547636a6f918230da855363f
[information]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3310
[parking-information]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330d
[path]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330e
[timings]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3312
[train-positions-faq]: https://developer.wmata.com/TrainPositionsFAQ
[alerts]: https://developers.google.com/transit/gtfs-realtime/guides/service-alerts
[trip-updates]: https://developers.google.com/transit/gtfs-realtime/guides/trip-updates
[vehicle-positions]: https://developers.google.com/transit/gtfs-realtime/guides/vehicle-positions
