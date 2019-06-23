# WMATA.swift

WMATA.swift is a lightweight Swift interface to the [Washington Metropolitan Area Transit Authority API](https://developer.wmata.com).


## Requirements
- Swift 5.1+

## Installation

### Swift Package Manager
```swift
dependencies: [
.package(url: "https://github.com/emma-foster/WMATA.swift.git", from: "1.0.0")
]
```

## Usage

### Getting Started
```swift
import WMATA

WMATA(apiKey: apiKey)[.A01].nextTrains { (nextTrains, error) in
    print(nextTrains?.trains, error)

}
```

### Design
WMATA.swift breaks the WMATA API into three pieces for each of MetroRail and MetroBus. 

| MetroRail  | MetroBus |
| ------------- | ------------- |
| `Rail` | `Bus`  |
| `Line`  | `Route` |
| `Station` | `Stop` |
| `WMATA`|

#### WMATA
`WMATA` provides quick access to `Rail` and `Bus` objects, as well as provides a convienince subscripting for `Line`, `Station` and `Route`s via `enum`s and `Bus` via `String`.

#### MetroRail
 `Rail` provides general methods applicable to the entire MetroRail system.
 `Line` provides methods applicable to MetroRail lines (I.E. Blue, Red, Green). 
 `Station` provides methods applicable to individual MetroRail stations (Metro Center).

#### MetroBus
`Bus` provides general methods applicable to the entire MetroBus system.
`Route` provides methods applicable to a particular route (I.E. A12)
`Stop` provides methods applicable to individual stops (I.E. 1001195)

### Using `Rail`
 `Rail` provides general methods applicable to the entire MetroRail system.
 
 #### `lines`
 [WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330c)
 Returns basic information on all MetroRail lines.
 
 ```swift
 Rail(apiKey: apiKey).lines { (lines, error) in
    print(lines, error)
}
 ```
 
 #### `entrances`
[WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330f?) 
Station entrances within a latlong pair and radius (in meters). Omit all parameters to receive all entrances.

```swift
Rail(apiKey: apiKey).entrances(latitude: nil, longitude: nil, radius: nil) { (entrances, error) in
    print(entrances, error)
}
```

#### `stations`
[WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311?)
Stations along a Line (optional)

```swift
Rail(apiKey: apiKey).stations(for: .BL) { (stations, error) in
    print(stations, error)
}
```

#### `station`
[WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3313?)
Distance, fare information and estimated travel time between two stations. Omit both station codes for all possible trips.

```swift
Rail(apiKey: apiKey).station(.A01, to: .A02) { (stationToStationInfos, error) in 
    print(stationToStationInfos, error)
}
```

#### `positions`
[WMATA Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/5763fb35f91823096cac1058)
Uniquely identifiable trains in service and what track circuits they currently occupy

```swift
Rail(apiKey: apiKey).positions { (positions, error) in
    print(positions, error)
}
```

#### `routes`
[WMATA Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57641afc031f59363c586dca?)
Ordered list of track circuits, arranged by line and track number

```swift
Rail(apiKey: apiKey).routes { (routes, error) in 
    print(routes, error)
}
```

#### `circuits`
[WMATA Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57644238031f59363c586dcb?)
List of all track circuits - also see [TrainPositionsFAQ](https://developer.wmata.com/TrainPositionsFAQ)

```swift
Rail(apiKey: apiKey).circuits { (circuits, error) in 
    print(ciruits, error)
}
```

#### `elevatorAndEscalatorIncidents`
[WMATA Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d76?)
Reported elevator and escalator incidents

```swift
Rail(apiKey: apiKey).elevatorAndEscalatorIncidents(at: .A01) { (incidents, error) in
    print(incidents, error)
}
```

#### `incidents`
[WMATA Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d77?)
Reported MetroRail incidents at a particular station (optional)

```swift
Rail(apiKey: apiKey).incidents(at: nil) { (incidents, error) in
    print(incidents, error)
}
```

### Using `Line`
 `Line` provides methods applicable to MetroRail lines (I.E. Blue, Red, Green). 
 
 `Line` provides the `Line.Code` enum to refer to each MetroRail line.
 
 #### `stations`
 [WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311?)
 Stations along a Line
 
 ```swift
 Line(apiKey: apiKey, line: .BL).stations { (stations, error) in 
    print(stations, error)
}
 ```
 
 ### Using `Station`
  `Station` provides methods applicable to individual MetroRail stations (Metro Center).
  
  `Station` defines `Station.Code` for identifying MetroRail stations.
  
  #### `nextTrains`
  [WMATA Documentation](https://developer.wmata.com/docs/services/547636a6f9182302184cda78/operations/547636a6f918230da855363f)
  Next train arrivals for this station.
  
  ```swift
Station(apiKey: apiKey, code: .A01).nextTrains { (nextTrains, error) in
    print(nextTrains, error)
}
```
  
  #### `information`
  [WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3310?)
  Location and address information for this station.
  
  ```swift
Station(apiKey: apiKey, code: .A01).information { (information, error) in
    print(information, error)
}
```

#### `parkingInformation`
[WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330d?)
Parking information for this station.

```swift
Station(apiKey: apiKey, code: .A01).parkingInformation { (parkingInformation, error} in
    print(parkingInformation)
}
```

#### `path`
[WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330e?)
Returns a set of ordered stations and distances between stations *on the same line*

```swift
Station(apiKey: apiKey, code: .A01).path(to: .A02) { (pathBetweenStations, error) in
    print(pathBetweenStations, error))
}
```

#### `timings`
[WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3312?)
Opening times and scheduled first and last trains for this station

```swift
Station(apiKey: apiKey, code: .A01).timings { (timings, error) in
    print(timings, error)
}
```

#### `to`
[WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3313?)
Distance, fare and estimated travel time between this and another station, *including stations on a different line*

```swift
Station(apiKey: apiKey, code: .A01).to(.A02) { (stationToStationInfos, error) in
    print(stationToStationInfos, error)
}
```

### Using `Bus`
`Bus` provides general methods applicable to the entire MetroBus system.

#### `positions`
[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68)
Bus positions along a route (optional), at a latlong and within a radius (in meters)

```swift
Bus(apiKey: apiKey).positions(routeId: ._10A, latitude: nil, longitude: nil, radius: nil) { (positions, error) in
    print(positions, error)
}
```

#### `routes`
[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6a?)
All bus routes

```swift
Bus(apiKey: apiKey).routes { (routes, error) in
    print(routes, error)
}
```

#### `searchStops`
[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6d?)
Stops near a given latlong and within a given radius. Omit all parameters to receive all stops.

```swift
Bus(apiKey: apiKey).searchStops(latitude: nil, longitude: nil, radius: nil) { (stops, error) in
    print(stops, error)
}
```

#### `incidents`
[WMATA Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d75?)
MetroBus incidents along an optional route.

```swift
Bus(apiKey: apiKey).incidents(route: ._10A) { (incidents, error) in
    print(incidents, error)
}
```

### Using `Route`
`Route` provides methods applicable to a particular route (I.E. A12)

`Route` defines `Route.Id` to identify routes. Note: Ids which start with a number are prefixed by an underscore (I.E. `.10A` is actually `._10A`   due to Swift naming limitations. This does not effect the `rawValue` of the value.

#### `positions`
[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68)
Bus positions along this route, within an optional latlong and radius (in meters).

```swift
Route(apiKey: apiKey, routeId: ._10A).positions(latitude: nil, longitude: nil, radius: nil) { (positions, error) in
    print(positions, error)
}
```

#### `pathDetails`
[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d69?)
Ordered latlong points along this Route for a given date (in `YYYY-MM-DD` format). Omit for today.

```swift
Route(apiKey: apiKey, routeId: ._10A).pathDetails { (pathDetails, error) in
    print(pathDetails, error)
}
```

#### `schedule`
[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6b?)
Scheduled stops for this Route

```swift
Route(apiKey: apiKey, routeId: ._10A).schedule { (stops, error) in
    print(stops, error))
}
```

### Using `Stop`
`Stop` provides methods applicable to individual stops (I.E. 1001195). Note that `Stops` are identified by 7-character regional stop IDs.

#### `nextBuses`
[WMATA Documentation](https://developer.wmata.com/docs/services/5476365e031f590f38092508/operations/5476365e031f5909e4fe331d)
Next bus arrivals at this Stop

```swift
Stop(apiKey: apiKey, stopId: "1001195").nextBuses { (buses, error) in
    print(buses, error)
}
```

#### `schedule`
[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6c?)
Buses scheduled to arrival at this Stop at a given date (in `YYYY-MM-DD` format, optional)

```swift
Stop(apiKey: apiKey, stopId: "1001195").schedule { (schedule, error) in
    print(schedule, error)
}
```

## Dependencies
None!

## Contact
Feel free to email questions and comments to [emma@emma.sh](mailto:emma@emma.sh)


## License

Alamofire is released under the MIT license. [See LICENSE](https://github.com/emma-foster/WMATA.swift/blob/master/LICENSE) for details.
