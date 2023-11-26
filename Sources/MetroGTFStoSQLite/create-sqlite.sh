#!/usr/bin/env zsh
# Use the [Node GTFS](https://github.com/BlinkTagInc/node-gtfs) package to build
# a SQLite database for GTFS Static data from WMATA.

npx -p gtfs gtfs-import --configPath gtfs-config.json
