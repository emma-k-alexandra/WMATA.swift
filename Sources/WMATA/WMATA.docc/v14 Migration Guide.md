# v14 Migration Guide

WMATA.swift v14 removes it's dependency on the GTFS package and corrects an issue where GTFS generated types were not accessible when using WMATA.swift

## Breaking changes

- Removed [`GTFS`][GTFS] dependency.

If you were using GTFS Static data types provided by GTFS through WMATA.swift, you will need to add the [GTFS][GTFS] package to your project manually.
If you use GTFS-RT types, those types are now included in WMATA.swift. No changes are required.

[GTFS]: https://github.com/emma-k-alexandra/GTFS
