# Using WMATA.swift

## Introduction
WMATA.swift provides a pure Swift interface to the [Washington Metropolitan Area Transit Authority API][wmata] and some supplemental data about MetroRail Stations and Lines.

## Getting your API key
To access the WMATA API, you'll need to get an API by [signing up via WMATA][wmata-signup].

## Making Requests
You can make requests to WMATA's API using the [`MetroRail`][metro-rail-docs], [`Station`][station-docs], [`Line`][line-docs], [`MetroBus`][metro-bus-docs], [`Stop`][stop-docs] or [`Route`][route-docs] types, depending on your needs. `MetroRail` and `MetroBus` have access to all Rail or Bus related calls respectively whereas `Station`, `Line`, `Stop` and `Route` provide fewer, contextual calls.

### Using Callbacks
The simplest way to make API calls is using a method that accepts a callback. Here's an example fetching the next trains for Metro Center via a `MetroRail` instance:

```swift
import WMATA

MetroRail(key: apiKey).nextTrains(at: .A01) { result in
    switch result {
    case let .success(predictions):
        print(predictions)

    case let .failure(error):
        print(error)
    }
}
```
Each callback returns a [`Result`][result] enum providing a response instance or an error. Both cases should be handled as network calls can fail for many reasons.

### Using Combine
If you're able to use Combine in your project, WMATA.swift provides [`Publisher`][publisher]s for every possible API call on all structures. Publisher methods have the "Publisher" suffix.

```swift
import WMATA
import Combine

let bus = MetroBus(key: apiKey)

let cancellable = bus
    .incidentsPublisher(on: "10A")
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                print(error)
            case .finished:
                print("Success")
            }
        },
        receiveValue: { value in
            print(value)
        }
    )
    
```
Publisher methods return an [`AnyPublisher`][any-publisher] instance with your response, so you can apply any of the typical `Publisher` operators to suit your needs.

### Using `WMATADelegate`
You can make background requests using a delegate on `MetroRail` or `MetroBus`. See [Background Requests][background-docs] for details.

### Specifying Stations, Lines, Stops and Routes
Rather than names, WMATA uses codes to identify stations, lines, stops and routes. MetroRail stations and lines are fairly static and thus are defined as enums within WMATA.swift. MetroBus stops and routes are far more numerous and fluid and thus are defined as structs that can be represented by String literals, as in the above Combine example.

[wmata]: https://developer.wmata.com
[metro-rail-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/MetroRail.md
[station-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Station.md
[line-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Line.md
[metro-bus-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/MetroBus.md
[stop-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Stop.md
[route-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Route.md
[background-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Background.md
[result]: https://developer.apple.com/documentation/swift/result
[publisher]: https://developer.apple.com/documentation/combine/publisher
[wmata-signup]: https://developer.wmata.com/signup/
[any-publisher]: https://developer.apple.com/documentation/combine/anypublisher
