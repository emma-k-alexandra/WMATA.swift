# Responses

How to handle data you receive back from an API.

## Overview

Every ``Endpoint`` has a ``Endpoint/Response``. This is the structure returned by the WMATA API, with some additions. This package attempts to enrich responses from the WMATA API with useful structures. Responses vary between the Standard API and GTFS API.

## Standard API

The Standard API returns JSON and is where this package focuses heavily. Responses from the Standard API are `Codable` and generally match the shape of responses from WMATA with a few (hopefully welcome) additions. 

When using the Standard API, you'll be able to treat the response as a typical Swift struct.

Here's some examples of what you'll find in these responses. Let's look at ``Rail/NextTrains`` as an example.

### Stations and Lines

This package converts station codes and line codes into ``Station`` and ``Line`` respectively. So, in WMATA's response for the ``Rail/NextTrains`` API, you could receive `E10` as a destination station. However, ``Rail/NextTrains/Response/Prediction/destination`` maps `E10` to ``Station/greenbelt`` instead. You can still receive the original station code by calling `rawValue` on ``Station/greenbelt``. ``Station`` instances also provide many helper variables and functions to receive data this is not available via the API.

Similarly for line codes, `BL` gets converted to ``Line/blue`` in many responses. MetroBus stops and routes are also marked as their own type, but they are simply backed by strings with no additional information available.

### Data Wrangling

In some cases data that comes from WMATA's API can be deceiptful or confusing. This package makes attempts to place this data into nicer formats. Let's look at some examples.

In the ``Rail/NextTrains`` API, the `Car` field, for checking the number of cars a train has, can be `"6"` or `"8"`, as you might expect from typical MetroRail usage. However, it can also be `"-"` or `nil`. Stange values that can be tricky to check for since all of this data is just a string. In this package ``Rail/NextTrains/Response/Prediction/car`` is parsed and is an optional enum that can only be `.six`, `.eight` or `nil`.

Again in the ``Rail/NextTrains`` API, the `Min` field, for checking the minutes until a train arrives, can be a number within a string, `"ARR"`, `"BRD"`, `"---"` or `""`. Again, this is confusing and difficult to parse. In this package ``Rail/NextTrains/Response/Prediction/minutes-swift.property`` is parsed into an enum with possible values `.minutes(Int)`, `.arriving`, `.boarding`, or `.unknown`. This should allow you to more easily parse the data coming from WMATA's API in your app in a swifty way.

You'll find these kind of additions in many responses.

## GTFS API

The GTFS responses are actually instances of [Protocol Buffer](https://developers.google.com/protocol-buffers) structures. When you make a call, you'll receive a [`TransitRealtime_FeedMessage`](https://github.com/emma-k-alexandra/GTFS/blob/main/Sources/GTFS/gtfs_realtime.pb.swift#L55) that you'll need to parse through for data relevant to your call. Here's an example.

```swift
let response = try! await endpoint.request().get() # In your code, unwrap properly

try response.jsonString()
```

Then, you would need to build your own structures to decode this JSON string. I hope to bring better support for GTFS structures in the future.
