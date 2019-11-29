# WMATA.swift

WMATA.swift is a lightweight Swift interface to the [Washington Metropolitan Area Transit Authority API](https://developer.wmata.com).

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
  - [Getting Started](#getting-started)
  - [Design](#design)
  - [New in v4](#new-in-v4)
  - [Using `MetroRail`](#using-MetroRail)
  - [Using `MetroBus`](#using-MetroBus)
  - [Background Requests & `WMATADelegate`](#background-requests--wmatadelegate)
- [Dependencies](#dependencies)
- [Testing](#testing)
- [Contact](#contact)
- [License](#license)

## Requirements

- Swift 5.1+

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/emma-foster/WMATA.swift.git", from: "5.4.0")
]
```

## Usage

### Getting Started

```swift
import WMATA

MetroRail(key: apiKey).nextTrains(at: .A01) { result in
    switch result {
    case .success(let predictions):
        print(predictions)

    case .failure(let error):
        print(error)

    }

}
```

### Design

WMATA.swift breaks the WMATA API into MetroRail and MetroBus via the `MetroRail` and `MetroBus`.

### New in v4

`MetroRail` and `MetroBus` still have all API methods associated with MetroRail and MetroBus respectively. In addition, `Stop`, `Route`, `Line` and `Station` have all API methods relevant to their respective data types. So, for example you can now call `nextBuses` on `Stop` and receive the next buses for that stop, without needing a `MetroBus` object.

### Using `MetroRail`

#### `lines`

 [WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330c)  
 Returns basic information on all MetroRail lines.

```swift
 MetroRail(key: apiKey).lines { result in
    switch result {
    case .success(let lines):
        print(lines)

    case .failure(let error):
        print(error)

    }

}
```

#### `entrances`

[WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330f?)  
Station entrances within a latlong pair and radius (in meters). Omit all parameters to receive all entrances.

```swift
MetroRail(key: apiKey).entrances(at: RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))) { result in
    switch result {
    case .success(let entrances):
        print(entrances)

    case .failure(let error):
        print(error)

    }

}
```

#### `stations`

[WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311?)  
Stations along a Line (optional)

```swift
MetroRail(key: apiKey).stations(for: .BL) { result in
    switch result {
    case .success(let stations):
        print(stations)

    case .failure(let error):
        print(error)

    }

}
```

#### `station`

[WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3313?)  
Distance, fare information and estimated travel time between two stations. Omit both station codes for all possible trips.

```swift
MetroRail(key: apiKey).station(.A01, to: .A02) { result in 
    switch result {
    case .success(let travelInfo):
        print(travelInfo)

    case .failure(let error):
        print(error)

    }

}
```

#### `positions`

[WMATA Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/5763fb35f91823096cac1058)  
Uniquely identifiable trains in service and what track circuits they currently occupy

```swift
MetroRail(key: apiKey).positions { result in
    switch result {
    case .success(let positions):
        print(positions)

    case .failure(let error):
        print(error)

    }

}
```

#### `routes`

[WMATA Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57641afc031f59363c586dca?)  
Ordered list of track circuits, arranged by line and track number

```swift
MetroRail(key: apiKey).routes { result in 
    switch result {
    case .success(let routes):
        print(routes)

    case .failure(let error):
        print(error)

    }

}
```

#### `circuits`

[WMATA Documentation](https://developer.wmata.com/docs/services/5763fa6ff91823096cac1057/operations/57644238031f59363c586dcb?)  
List of all track circuits - also see [TrainPositionsFAQ](https://developer.wmata.com/TrainPositionsFAQ)

```swift
MetroRail(key: apiKey).circuits { result in 
    switch result {
    case .success(let circuits):
        print(circuits)

    case .failure(let error):
        print(error)

    }

}
```

#### `elevatorAndEscalatorIncidents`

[WMATA Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d76?)  
Reported elevator and escalator incidents

```swift
MetroRail(key: apiKey).elevatorAndEscalatorIncidents(at: .A01) { result in
    switch result {
    case .success(let incidents):
        print(incidents)

    case .failure(let error):
        print(error)

    }

}
```

#### `incidents`

[WMATA Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d77?)  
Reported MetroRail incidents at a particular station (optional)

```swift
MetroRail(key: apiKey).incidents(at: .A01) { result in
    switch result {
    case .success(let incidents):
        print(incidents)

    case .failure(let error):
        print(error)
    }

}
```

#### `stations`

 [WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311?)  
 Stations along a Line

```swift
 MetroRail(key: apiKey).stations(for: .BL) { result in 
    switch result {
    case .success(let stations):
        print(stations)

    case .failure(let error):
        print(error)

    }

}
```

#### `nextTrains`

  [WMATA Documentation](https://developer.wmata.com/docs/services/547636a6f9182302184cda78/operations/547636a6f918230da855363f)  
  Next train arrivals for this station.

```swift
MetroRail(key: apiKey).nextTrains(at: .A01) { result in
    switch result {
    case .success(let predictions):
        print(predictions)

    case .failure(let error):
        print(error)

    }

}
```

#### `information`

  [WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3310?)  
  Location and address information for this station.

```swift
MetroRail(key: apiKey).information(for: .A01) { result in
    switch result {
    case .success(let information):
        print(information)

    case .failure(let error):
        print(error)

    }

}
```

#### `parkingInformation`

[WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330d?)  
Parking information for this station.

```swift
MetroRail(key: apiKey).parkingInformation(for: .A01) { result in
    switch result {
    case .success(let parkingInfo):
        print(parkingInfo)

    case .failure(let error):
        print(error)

    }

}
```

#### `path`

[WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe330e?)  
Returns a set of ordered stations and distances between stations *on the same line*

```swift
MetroRail(key: apiKey).path(from: .A01 to: .A02) { result in
    switch result {
    case .success(let path):
        print(path)

    case .failure(let error):
        print(error)

    }

}
```

#### `timings`

[WMATA Documentation](https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3312?)  
Opening times and scheduled first and last trains for this station

```swift
MetroRail(key: apiKey).timings(for: .A01) { result in
    switch result {
    case .success(let timings):
        print(timings)

    case .failure(let error):
        print(error)

    }

}
```

### Using `MetroBus`

#### `positions`

[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68)  
Bus positions along a route (optional), at a latlong and within a radius (in meters)

```swift
MetroBus(key: apiKey).positions(on: ._10A, at: RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))) { result in
    switch result {
    case .success(let positions):
        print(positions)

    case .failure(let error):
        print(error)

    }

}
```

#### `routes`

[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6a?)  
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

#### `searchStops`

[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6d?)  
Stops near a given latlong and within a given radius. Omit all parameters to receive all stops.

```swift
MetroBus(key: apiKey).searchStops(at: RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))) { result in
    switch result {
    case .success(let stops):
        print(stops)

    case .failure(let error):
        print(error)

    }

}
```

#### `incidents`

[WMATA Documentation](https://developer.wmata.com/docs/services/54763641281d83086473f232/operations/54763641281d830c946a3d75?)  
MetroBus incidents along an optional route.

```swift
MetroBus(key: apiKey).incidents(on: ._10A) { result in
    switch result {
    case .success(let incidents):
        print(incidents)

    case .failure(let error):
        print(error)

    }

}
```

#### `positions`

[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d68)  
Bus positions along this route, within an optional latlong and radius (in meters).

```swift
MetroBus(key: apiKey).positions(at: ._10A, at: RadiusAtCoordinates(radius: 1000, coordinates: Coordinates(latitude: 38.8817596, longitude: -77.0166426))) { result in
    switch result {
    case .success(let positions):
        print(positions)

    case .failure(let error):
        print(error)

    }

}
```

#### `pathDetails`

[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d69?)  
Ordered latlong points along this Route for a given date. Omit for today.

```swift
MetroBus(key: apiKey).pathDetails(for: ._10A) { result in
    switch result {
    case .success(let path):
        print(path)

    case .failure(let error):
        print(error)

    }

}
```

#### `schedule`

[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6b?)  
Scheduled stops for this Route

```swift
MetroBus(key: apiKey).schedule(for: ._10A) { result in
    switch result {
    case .success(let schedule):
        print(schedule)

    case .failure(let error):
        print(error)

    }

}
```

#### `nextBuses`

[WMATA Documentation](https://developer.wmata.com/docs/services/5476365e031f590f38092508/operations/5476365e031f5909e4fe331d)  
Next bus arrivals at this Stop

```swift
MetroBus(key: apiKey).nextBuses(for: Stop(id: "1001195")) { result in
    switch result {
    case .success(let predictions):
        print(predictions)

    case .failure(let error):
        print(error)

    }

}
```

#### `schedule`

[WMATA Documentation](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6c?)  
Buses scheduled to arrival at this Stop at a given date. Omit for today.

```swift
MetroBus(key: apiKey).schedule(for: Stop(id: "1001195")) { result in
    switch result {
    case .success(let schedule):
        print(schedule)

    case .failure(let error):
        print(error)

    }

}
```

## Background Requests & `WMATADelegate`

Background requests can be made using a`WMATADelegate` on `MetroRail` or `MetroBus`. First, create a class implementing `WMATADelegate`:

```swift
import WMATA

class Delegate: WMATADelegate {

}
```

Then implement the `received` method for whichever method you plan on calling on the `MetroBus` or `MetroRail` object this delegate belongs to. For example, if yoy plan on calling `lines` on `MetroRail`, implement `received(linesResponse:` on your delegate.

```swift
class Delegate: WMATADelegate {
    func received(linesResponse result: Result<LinesResponse, WMATAError>) {
        switch result {
        case .success(let lines):
            print(lines)

        case .failure(let error):
            print(error)

        }

    }

}
```

Finally, create a `MetroBus` or `MetroRail` instance with an instance of your delegate and make requests!

```swift
let delegate = Delegate()
let metroRail = MetroRail(key: apiKey, delegate: Delegate())
```

## Dependencies

None!

## Testing

Currently, afaik Xcode doesn't provide a way to run tests in succession rather than in parallel. So, as of v5, tests musts be run manually & individually. No fun, I know. Working on a solution for future versions.

## Contact

Feel free to email questions and comments to [emma@emma.sh](mailto:emma@emma.sh)

## License

WMATA.swift is released under the MIT license. [See LICENSE](https://github.com/emma-foster/WMATA.swift/blob/master/LICENSE) for details.
