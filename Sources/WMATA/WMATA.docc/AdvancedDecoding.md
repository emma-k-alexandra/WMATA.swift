# Decoding Yourself

Decode responses from the WMATA API yourself

## Overview

If you are persisting responses from the WMATA API in your application, you may need to decode those responses later outside of the usual structures provided in this package. This is possible by using the same decoding methods using within this package.

## The WMATADecoding Protocol

Internally this package uses the ``WMATADecoding`` protocol to decode responses from both the Standard and GTFS APIs. This protocol is also available to you. Simply adopt the protocol on your own object and call the ``WMATADecoding/decode(standard:)-3so7u`` or ``WMATADecoding/decode(gtfs:)-7ucan`` functions on your object. These methods return a `Result` with your ``Endpoint/Response`` or a ``WMATAError``.

### Example

```swift
struct CustomDecoder: WMATADecoding {
    ...
}

let decoder = CustomerDecoder()
let data: Data = YOUR_SAVED_RESPONSE_DATA

let result: Result<Rail.StationEntrances.Response, WMATAError> = decoder.decode(standard: data)

switch result {
    case let .success(response):
        print(response)
    case let .failure(error):
        print(error)
}
```

## Standard API Decoder

``WMATADecoding`` uses ``WMATAJSONDecoder`` when decoding Standard API responses. You can create your own instances of this custom decoder. This decoder makes use of `convertFromWMATA` decoding strategy defined on [`JSONDecoder.KeyDecodingStrategy`](https://developer.apple.com/documentation/foundation/jsondecoder/keydecodingstrategy), which is also available to you. This decoder also uses the `wmataFormat` date format defined on [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter), also available to you. These custom decoding strategies are required in order to properly decode data from the WMATA API, which is often structured strangely or in a non-standard way.

### Example

```swift
let decoder = WMATAJSONDecoder()
let data: Data = YOUR_STANDARD_API_RESPONSE_DATA

let result = try WMATAJSONDecoder().decode(Bus.StopsSearch.Response.Self, from: data)

switch result {
    case let .success(response):
        print(response)
    case let .failure(error):
        print(error)
}
```

## GTFS API Decoding

GTFS API responses are protocol buffer messages. In order to decode yourself simply

```swift
let data: Data = YOUR_GTFS_API_RESPONSE_DATA

let message = try TransitRealtime_FeedMessage(serializedData: data)
```

## Custom Decoding

If you'd like to define your own structurs to decode into, this package provides the propery wrapper ``MapToNil`` that allows you to make `Codable` values in responses to `nil` as a helper. It is not required for custom decoding.

```swift
struct CustomResponse: Codable {
    ...
    @MapToNil<Station, EmptyString> var station: Station?
    ...
}
```

You can create custom values to map to nil in your response structure by adopting ``WMATAMappedValues``.


## Topics

### Decoding Responses

- ``WMATADecoding``
- ``WMATAJSONDecoder``

### Custom Decoding
- ``MapToNil``
- ``WMATAMappedValues``

### Custom Values
- ``DashesAndNo``
- ``EmptyString``
- ``SingleDash``
- ``SingleZero``
- ``SingleIntZero``
