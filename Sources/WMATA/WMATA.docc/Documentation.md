# ``WMATA``

WMATA is an interface to the Washington Metropolitan Area Transit Authority API.

## Overview

WMATA supports both the Standard and GTFS APIs for both MetroRail and MetroBus. WMATA uses a series of ``Endpoint``s to make requests to the WMATA API on your behalf. WMATA augments some responses from the API with structures like ``Station`` and ``Stop`` that allow you to get additional information without calling the API.

![A MetroRail station with a train passing](center-platforms)

## Quickstart

To jump right in, get an API Key by making an account on [WMATA's Developer Website](https://developer.wmata.com). Then, pick an endpoint from ``Rail``, ``Bus``, ``Rail/GTFS`` or ``Bus/GTFS`` to call. Make your ``Endpoint`` instance and make your request.

```swift
let nextTrains = Rail.NextRails(
    key: YOUR_API_KEY,
    station: .waterfront
)

nextTrains.request { result in 
    switch result {
    case let .success(response):
        print(response.trains)
    case let .failure(error):
        print(error)
    }
}
```

For more details, check out <doc:Endpoints>.

## Topics

### Getting Started

- ``APIKey``
- <doc:Endpoints>
- <doc:Responses>
- <doc:StandardGTFSAPI>

### MetroRail

- ``Station``
- ``Line``
- ``Rail``
- ``Rail/GTFS``

### MetroBus

- ``Stop``
- ``Route``
- ``Bus``
- ``Bus/GTFS``

### Supporting structures

- ``WMATALocation``
- ``WMATAError``

### Background Requests

- <doc:BackgroundRequests>
- ``JSONEndpointDelegate``
- ``GTFSEndpointDelegate``

### Advanced

- <doc:AdvancedDecoding>

### Updating from Previous Versions

- <doc:v11-Migration-Guide>

[wmata]: https://developer.wmata.com
