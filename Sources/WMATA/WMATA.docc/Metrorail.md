# Metrorail

Structures and Endpoints for calling Metrorail APIs.

## Overview

Metrorail APIs are used to retrieve information about train stations, routes and tracks. 

In this package ``Station`` represents a train station and is an enumeration of all current and future Metrorail stations. You can use `Station` instances to retrieve additional information about a station without making a network request to the API.

``Line`` represents the colorful train lines of the Metrorail system and is also an enumeration of all current lines. You can use `Line` instances to retrieve additional information about a line without making a network request.

## Topics

### Structures

- ``Station``
- ``Line``

### Standard Endpoints

- ``Rail/Lines``
- ``Rail/StationEntrances``
- ``Rail/TrainPositions``
- ``Rail/StandardRoutes``
- ``Rail/TrackCircuits``
- ``Rail/StationToStation``
- ``Rail/ElevatorAndEscalatorIncidents``
- ``Rail/Incidents``
- ``Rail/NextTrains``
- ``Rail/StationInformation``
- ``Rail/ParkingInformation``
- ``Rail/PathBetweenStations``
- ``Rail/StationTimings``
- ``Rail/Stations``

### GTFS Endpoints

- ``Rail/GTFS/Alerts``
- ``Rail/GTFS/TripUpdates``
- ``Rail/GTFS/VehiclePositions``
