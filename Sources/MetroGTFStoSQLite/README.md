# Metro GTFS to SQLite

Create a SQLite database from WMATA's Static MetroRail GTFS data.

## Requirements

- [Node.js](https://nodejs.org) v18 or higher
- [SQLite](https://sqlite.org/index.html), built in on all Macs

## Usage

This package uses the awesome [`node-gtfs`](https://github.com/BlinkTagInc/node-gtfs) package to build the SQLite database. This means you will need Node.js installed.
If you do not regularly use Node.js I recommend using [pkgx](https://pkgx.sh) or [brew](https://formulae.brew.sh/formula/node) to use Node.

If you use pkgx, no additional setup is required. Skip to [Create SQLite Database](#create-sqlite-database).

If installing Node.js with brew, run

```zsh
brew install node
```

This will install the current version of Node.js.

### Create SQLite database

To use `node-gtfs` to create the SQLite database run

```zsh
./create-sqlite.sh
```

You will now have a new SQLite database in this directory called `MetroGTFS.sqlite3` that contains all MetroRail GTFS static data.

## Todo

This project is fairly new and therefore currently has limited capabilities. In the future,
I would like to see the following implemented

- [ ] Fetch GTFS data from WMATA's developer API
- [ ] MetroBus GTFS support
- [ ] GTFS-RT support
