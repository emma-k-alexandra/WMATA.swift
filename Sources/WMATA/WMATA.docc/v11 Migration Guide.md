# v11 Migration Guide

WMATA.swift v11 is a complete overhaul of the package. Likely, all previous code will need to be reworked.

Majors changes were made to the package in order to vastly simplify the code base. I think you'll find the new structure of the package to be much simpler to use and matches your workflow better.

If you have previously worked with WMATA.swift I recommend reading <doc:Endpoints> to understand the new structure of this package.

## Breaking changes

- `MetroRail` and `MetroBus` have been removed.

Use endpoints in ``Rail``, ``Bus``, ``Rail/GTFS`` or ``Bus/GTFS`` instead.

- You can no longer make API calls from ``Station``, ``Line``, ``Stop`` or ``Route`` instances.

Use endpoints in ``Rail``, ``Bus``, ``Rail/GTFS`` or ``Bus/GTFS`` instead.

- ``Stop`` and  ``Route`` are now typealiases for `String` rather than structs.

- `WMATADelegate` has been replaced with ``EndpointDelegate``.

- `RadiusAtCoordinates` has been renamed ``WMATALocation``.

- ``WMATAError`` is now an enum.


## Deprecations

- ``Station`` and ``Line`` enums now use names like ``Station/ballston`` rather than codes.

You can currently still use codes, but they are deprecated and Xcode will assist you in renaming your hardcoded station and line instances. You can get the station code by calling `rawValue` on a `Station` or `Line` instance.

- 
