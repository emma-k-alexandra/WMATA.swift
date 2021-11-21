# ``WMATA``

WMATA is an interface to the Washington Metropolitan Area Transit Authority API.

## Overview

WMATA supports both the Standard and GTFS APIs for both MetroRail and MetroBus. WMATA uses a series of ``Endpoint``s to make requests to the WMATA API on your behalf. WMATA augments some responses from the API with structures like ``Station`` and ``Stop`` that allow you to get additional information without calling the API.

![A MetroRail station with a train passing](center-platforms)

## Topics

### Getting Started

- <doc:GettingStarted>
- <doc:Endpoints>
- <doc:Responses>
- <doc:GTFSStandardAPI>

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

[wmata]: https://developer.wmata.com
