# Using `Station`

The `Station` enum provides values for all MetroRail stations.

## Definition

```swift
public enum Station {
    case A01
    case A02
    case A03
    case A04
    case A05
    ...
}
```

Values use WMATA station codes rather than names.

### Current values
To see all current station codes, inspect the enum manually or check the [Station Information][station-information] API from WMATA, which is available on `MetroRail` as the `stations` method.

### Unused values
The codes `.N07`, `.N10`, `.N11`, `.N12`, `.N14`, `.N15` and `.C11` correspond to stations that will open as part of the Silver Line Phase 2 and Potomac Yard expansions and are not currently used by WMATA.

### Transfer stations
`Station` codes more closely correspond to platforms within a physical station. Most stations only have one platform and thus one `Station` value. However, physical stations that contain multiple levels require multiple `Station` values to receive all information about a physical station. These stations are

- Metro Center: `.A01`, `.C01`
- L'Enfant Plaza: `.D03`, `.F03`
- Gallery Place/Chinatown: `.B01`, `.F01`
- Fort Totten: `.B06`, `.E06`

## Callback methods

### `station`

[WMATA Documentation][station]
Distance, fare information and estimated travel time between two stations.

```swift
Station.A01.station(to: .A02, key: apiKey) { result in 
    switch result {
    case let .success(travelInfo):
        print(travelInfo)

    case let .failure(error):
        print(error)
    }
}
```

### `elevatorAndEscalatorIncidents`

[WMATA Documentation][elevator-and-escalator-incidents]  
Reported elevator and escalator incidents at this station

```swift
Station.A01.elevatorAndEscalatorIncidents(key: apiKey) { result in
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
Reported MetroRail incidents at this station

```swift
Station.A01.incidents(key: apiKey) { result in
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
Station.A01.nextTrains(key: apiKey) { result in
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
Station.A01.information(key: apiKey) { result in
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
Station.A01.parkingInformation(key: apiKey) { result in
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
Station.A01.path(to: .A02, key: apiKey) { result in
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
Station.A01.timings(key: apiKey) { result in
    switch result {
    case let .success(timings):
        print(timings)

    case let .failure(error):
        print(error)
    }
}
```

## Combine Publisher methods
These methods access the WMATA API and return your result via a Combine [`Publisher`][publisher]. In modern projects, these methods should be your goto. Combine Publishers can't be used in the background. For more details on using Combine with WMATA.swift, check the [Combine][combine-docs] documentation.

### `stationPublisher`

[WMATA Documentation][station]
Distance, fare information and estimated travel time between two stations.

```swift
let cancellable = Station.A01
    .stationPublisher(to: .A02, key: apiKey)
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
Reported elevator and escalator incidents at this station

```swift
let cancellable = Station.A01
    .elevatorAndEscalatorIncidentsPublisher(key: apiKey)
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
Reported MetroRail incidents at this station

```swift
let cancellable = Station.A01
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

### `nextTrainsPublisher`

  [WMATA Documentation][next-trains]
  Next train arrivals for this station.

```swift
let cancellable = Station.A01
    .nextTrainsPublisher(key: apiKey)
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
let cancellable = Station.A01
    .informationPublisher(key: apiKey)
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
let cancellable = Station.A01
    .parkingInformationPublisher(key: apiKey)
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
let cancellable = Station.A01
    .pathPublisher(to: .A02, key: apiKey)
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
let cancellable = Station.A01
    .timingsPublisher(key: apiKey)
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

## Additional information

### `name`

The human presentable name of this line in English.

```swift
tation.A01.name // "Metro Center"
```

### `lines`

The `Line`s this is on without making a network request.

```swift
Station.A01.lines // [.BL, .OR, .SV, .RD]
```

### `open`

If a station is open to the public. False if a station if part of the Silver Line Phase 2 or Potomac Yard expansions. Otherwise true.

```swift
Station.N07.open // false, Reston Town Center is part of Silver Line Phase 2
```

### `together`

The `Station` code that shares a physical station with this `Station` code.

```swift
Station.B06.together == .E06 // Both station codes for Fort Totten
```

### `allTogether`

This `Station` and the `Station` that shares a physical station, if there is one, as an `Array`. Otherwise, just this `Station` in an `Array`.

```swift
Station.A01.allTogether // [ .A01, .C01 ]
```

### `openingTime(on:)`

The opening time of a station without making a network request. Note: This is only accurate generally, not on event days. For guaranteed accurate information use the `timings` method on a `Station` or `MetroRail`.

Optionally provide a `Date` to get opening times on the day of that `Date`.

```swift
Station.A01.openingTime() // "2020-01-12 08:14:00 +0000" as a `Date`
```

[station-information]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311
[station]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3313
[elevator-and-escalator-incidents]: https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d76
[incidents]: https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d77
[next-trains]: https://developer.wmata.com/docs/services/547636a6f9182302184cda78/operations/547636a6f918230da855363f
[information]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3310
[parking-information]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330d
[path]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330e
[timings]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3312
[combine-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Combine.md
[publisher]: https://developer.apple.com/documentation/combine/publisher
