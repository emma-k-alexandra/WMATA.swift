# Metrobus

Structures and Endpoints for calling Metrobus APIs.

## Overview

Metrobus APIs are used to retrieve information about bus stops and routes. 

In this package ``Stop`` represents a bus stop and a simply a `String` of a stop's ID like `1001037`.

``Route`` represents a bus route and is also a `String` of a route's ID like `10Av1`.
 
## Topics

### Structures

- ``Stop``
- ``Route``

### Standard Endpoints

- ``Bus/Positions``
- ``Bus/Incidents``
- ``Bus/PathDetails``
- ``Bus/RouteSchedule``
- ``Bus/NextBuses``
- ``Bus/StopSchedule``
- ``Bus/StopsSearch``
- ``Bus/Routes``

### GTFS Endpoints

- ``Bus/GTFS/Alerts``
- ``Bus/GTFS/TripUpdates``
- ``Bus/GTFS/VehiclePositions``
