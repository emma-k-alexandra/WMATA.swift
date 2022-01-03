# v13 Migration Guide

WMATA.swift v13 removes the long-unused Yellow Line Rush Plus line, as it's finally been removed from the WMATA API.

## Breaking changes

- Removed `Line.yellowLineRushPlus`.

Data for this line is no longer available from the Standard Routes API. You may need to remove references to this line in your response handling for calls to the ``Rail/StandardRoutes`` endpoint.

- Removed previously deprecated `Line.YLRP`.

## Deprecations

- ``Line/current``, simply remove all references to this property. All lines are current.

- ``Line/allCurrent``, use `Line.allCases` instead.
