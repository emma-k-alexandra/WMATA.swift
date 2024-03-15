#  MetroGTFS

Use [WMATA's Static GTFS data](https://developer.wmata.com/docs/services/gtfs/operations/bus-gtfs-static).

## Usage

See base [README.md](../../README.md).

## Warning

This package is in active development and is likely to change.

## Support

This package currently only supports WMATA's Rail GTFS data. Bus GTFS data will be added eventually.

The following GTFS data types are supported

| GTFS Files | Supported? |  
| - | - |
| stops.txt | ✅ | 
| agency.txt | ❌ | 
| levels.txt | ✅ | 
| routes.txt | ❌ | 
| trips.txt | ❌ | 
| stop_times.txt | ❌ | 
| calendar.txt | ❌ | 
| calendar_dates.txt | ❌ | 
| shapes.txt | ❌ | 
| pathways.txt | ❌ | 
| feed_info.txt | ❌ | 
| timepoints.txt | ❌ |
| timepoints_times.txt | ❌ |

Unlisted GTFS files are not provided by WMATA.
