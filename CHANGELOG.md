# Change Log

## v15.2 - MetroGTFS

Introduce a new package `MetroGTFS` that allows for friendler handling of [GTFS Static (also called GTFS Schedule)](https://gtfs.org/schedule/) data. The goal of this package is to be a better interface than my old [GTFS Package](https://github.com/emma-k-alexandra/GTFS).

MetroGTFS uses a SQLite database to store GTFS Static data. I'm hoping to build up support for more GTFS Static data over time. For now, the package is quite limited.

Web-based docs are not available for MetroGTFS yet. However, docs are available in Xcode via Build Documentation.

- Create MetroGTFS package
- Add dependency on SQLite.swift package
- Support GTFS Stops via `GTFSStop`
- Allow creation of a `GTFSStop` from a WMATA `Stop`
- Support GTFS Levels via `GTFSLevel`
- Create MetroGTFStoSQLite project, which uses JavaScript to pull an create the SQLite database used by MetroGTFS

## v15.1 - Potomac Yard

Potomac Yard station is now open, so a few non-breaking changes are happening in `Station`.

- `Station.allOpen` now returns all stations, so it is an alias for `Station.allCases` for now.
- `Station.open` always returns `true` since all stations are open.
- `Station.potomacYard.name` now returns `"Potomac Yard-VT"` instead of `"Potomac Yard"`, properly reflecting the official name of the station.
