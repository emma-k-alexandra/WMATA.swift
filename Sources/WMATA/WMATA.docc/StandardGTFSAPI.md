# Standard vs GTFS API

Choosing which API to use in your application.

## Overview

WMATA offers two APIs to choose from. Much of the data is similar between them, but the use cases are different between each API.

## Standard

The Standard API is a set of JSON APIs that comprises of most of the endpoints WMATA publishes. Every API except those under GTFS on [WMATA's APIs Page](https://developer.wmata.com/docs/services/) are considered part of the Standard API.

The Standard API is the best supported by this package, and is recommended for most applications. All WMATA publishes is available through the Standard API, but fetching that data may require more calls to various endpoints to receive than with the GTFS API.

## GTFS

The GTFS API is a set of 3 endpoints available for both Metrorail and Metrobus based on the [General Transit Feed Specification](https://gtfs.org). GTFS is a standard data format split into two parts: GTFS and GTFS-RT (Real Time). To receive GTFS data, which in the case of WMATA is simply a zip file, you will need to use the [GTFS Package](https://github.com/emma-k-alexandra/GTFS) directly. `GTFS` is a dependency of this package. This package only supports calling GTFS-RT endpoints published by WMATA.

GTFS-RT endpoints return data for the entire Metrobus or Metrorail system with a single call. This may save you from making multiple calls with the Standard API at the cost of larger and more complex responses. GTFS-RT endpoints return data via a [Protocol Buffer](https://developers.google.com/protocol-buffers) which can substantally reduce response size at the cost of complexity.

Protocol Buffers are not easily convertable into Swift structures. For example, [responses from the GTFS API are not `Codable`](https://github.com/apple/swift-protobuf/issues/657) and future `Codable` support looks bleak. So, you will encounter more difficulty parsing the responses from this API.

This package is looking to improve its GTFS support in the future. Until then, I highly recommend using the Standard API. However, if you still wish to use the GTFS API, it is certainly possible.

## Topics

### Standard API

- ``Rail``
- ``Bus``
- ``JSONEndpoint``
- ``JSONEndpointDelegate``

### GTFS API

- ``Rail/GTFS``
- ``Bus/GTFS``
- ``GTFSEndpoint``
- ``GTFSEndpointDelegate``
