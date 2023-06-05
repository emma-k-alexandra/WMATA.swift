# Change Log

## v15.1 - Potomac Yard

Potomac Yard station is now open, so a few non-breaking changes are happening in `Station`.

- `Station.allOpen` now returns all stations, so it is an alias for `Station.allCases` for now.
- `Station.open` always returns `true` since all stations are open.
- `Station.potomacYard.name` now returns `"Potomac Yard-VT"` instead of `"Potomac Yard"`, properly reflecting the official name of the station.
