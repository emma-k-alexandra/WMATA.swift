# Endpoints

Understanding endpoints and how to make requests the way you need.

## Overview

WMATA provides two formats for data from their API: JSON and GTFS. In this package, I refer to the JSON API as the "Standard API" and thr GTFS API as simply as the "GTFS API".

Endpoints in this package are split into four categories: ``Rail`` and  ``Bus`` for JSON APIs for MetroRail and MetroBus respectively, and ``Rail/GTFS`` and ``Bus/GTFS`` for GTFS APIs for MetroRail and MetroBus respectively.

Each API provided by WMATA is defined as an ``Endpoint`` within this package. So, the [MetroBus Routes API](https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6a) is defined as ``Bus/Routes`` and the [MetroRail Trip Updates GTFS API](https://developer.wmata.com/docs/services/gtfs/operations/5cdc51ea7a6be320cab064fe) is defined as ``Rail/GTFS/TripUpdates``. I would recommend exploring each namespace for relevant APIs. Names match with names on [WMATA's Developer Website](https://developer.wmata.com).

## Usage

An ``Endpoint`` allows you to call each API in a variety of ways. Swift has evolved to provide developers many way to make HTTP requests and this package supports most major styles. Each `Endpoint` requires an ``APIKey`` to make calls to WMATA's API. You can get an API by making an account on[WMATA's Developer Website](https://developer.wmata.com). Many endpoints also accept other parameters. Check the documentation for the API you're interested in to see relevant parameters.

> Note: This package makes an effort to support calling WMATA's APIs in all ways the API supports. If you find this package doesn't support calling APIs in a certain way, please file an issue on Github!

To use an endpoint, first you must create an instance of it. For this example, we'll call the ``Rail/ElevatorAndEscalatorIncidents`` API.

```swift
let incidents = Rail.ElevatorAndEscalatorIncidents(
    key: MY_API_KEY,
    station: .foggyBottom
)
```

Now, you need to decide how you want to receive the response from your request. This package provides four styles.

### Completion Handler

To make your request and receive your response with a completion handler call ``Endpoint/request(with:completion:)`` on your endpoint. You will receive a `Result` with either the ``Endpoint/Response`` for your API or a ``WMATAError``. You can make a request on the shared `URLSession` like so:

```swift
incidents.request { result
    switch result {
        case let .success(response):
            print(response)
        case let .failure(error):
            print(error)
    }
}
```

### Async/Await

To make your request using Swift's concurrency features call ``Endpoint/request(with:)`` on your endpoint. You will receive a `Result` with either the ``Endpoint/Response`` for your API or a ``WMATAError``. You can make a request on the shared `URLSession` within an `async` context like so:

```swift
let result = await incidents.request()

switch result {
    case let .success(response):
        print(response)
    case let .failure(error):
        print(error)
}
```

### Combine

To make your request and a receive a response via a Combine Publisher, call ``Endpoint/publisher(with:)`` on your endpoint. You will receive a `Publisher` with an `Output` of ``Endpoint/Response`` and a `Failure` of ``WMATAError``. You can make a request on the shared `URLSession` like so:

```swift
let cancellable = incident
    .publisher()
    .sink(
        receiveCompletion: { completion in 
            switch completion {
            case .finished:
                print("Done!")
            case let .failure(error):
                print(error)
            }
        },
        receiveValue: { response in 
            print(response)
        }
    )
```

### Delegate

You can requests while your application is in the background using an ``EndpointDelegate``. For more information see <doc:BackgroundRequests>.


## Topics

### Types of Endpoints

- ``JSONEndpoint``
- ``GTFSEndpoint``
- ``Endpoint``

### Ways to make Requests

- ``Endpoint/request(with:completion:)``
- ``Endpoint/request(with:)``
- ``Endpoint/publisher(with:)``
- ``Endpoint/backgroundRequest()``
