# v15 Migration Guide

Silver Line Extension Phase 2 stations are now included in open stations, plus station code changes.

## Breaking changes

## Silver Line Extension Phase 2 Stations

Some changes have been made for the opening of the new Silver Line stations.

- ``Station/herndon`` now has station code `N08`, previously `N08`.
- ``Station/innovationCenter`` now has station code `N09`, previously `N11`.
- ``Station/loudounGateway`` now has station code `N11`, previously `N14`.
- ``Station/ashburn`` now has station code `N12`, previously `N15`.
- ``Station/dullesInternationalAirport`` has been renamed ``Station/washingtonDullesInternationalAirport``.
- ``Station/washingtonDullesInternationalAirport`` now has station code `N10`, previously `N12`.

These Silver Line Extension Phase 2 station codes were added before WMATA releases official information about their station codes. Previously, they were based entirely off of speculation. Now the official station codes have been released.

As for the name change to Dulles, this new name matches this project's convention of following the official of the station for ``Station`` cases. WMATA seems to love giving airports particularly long station names. I'm looking at you, ``Station/ronaldReaganWashingtonNationalAirport``.

Xcode warnings with auto fix buttons have been added for all of these changes.

- ``Station/name`` will now return `Washington Dulles International Airport` for ``Station/washingtonDullesInternationalAirport``.

- ``Station/allOpen`` now includes all stations except ``Station/potomacYard``.

- ``Station/open`` will now return `true` for all stations except ``Station/potomacYard``.

## `Station.openingTime(on date:)`

- `Station.openingTime(on date:)` has been removed.
- The internal enum `WMATADay` has been removed.
- The internal `Date.wmataDay` extension has been removed.

The data provided by this method was likely not correct and I cannot commit to keeping it up to date.

If you need station opening times, consider using WMATA's GTFS Static data. [Available from WMATA's API directly](https://developer.wmata.com/docs/services/gtfs/operations/5cdc5367acb52c9350f69753), and can be parsed with [Richard Wolf's Transit package](https://github.com/richwolf/transit) (recommended) or my own [GTFS package](https://github.com/emma-k-alexandra/GTFS).

## Deprecations

- ``Station/dullesInternationalAirport`` has been deprecated in favor of ``Station/washingtonDullesInternationalAirport``. Auto-fix warning has been added.

## Removed Deprecated Fields

Properties that have been deprecated for some time have been removed.

- ``Station`` cases that use codes like `A03` rather than names like ``Station/dupontCircle`` have been removed.

These properties were originally introduced about a year ago in WMATA.swift v11 with auto-fix Xcode warnings available. Warnings for recently renamed stations are still available.

- ``Line`` cases that use codes like `RD` rather than names like ``Line/red`` have been removed.

Like with `Station` cases, these were introdcued in v11 with auto-fix Xcode warnings. So long!

- `Line.current` and `Line.allCurrent` have been removed.

These properties are deprecated with auto-fix warnings in v13 at the beginning of the year after the fantastic removal of Yellow Line Rush Plus from the API.
