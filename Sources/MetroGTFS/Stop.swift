//
//  GTFSStop.swift
//
//
//  Created by Emma on 11/25/23.
//

import Foundation
import SQLite

public extension GTFS {
    /// A [GTFS Stop](https://gtfs.org/schedule/reference/#stopstxt).
    ///
    /// For MetroRail, represents a Station, Platform, Entrance, or location between one of the previous stops like an elevator, escalator, or the paid and unpaid sides of a faregate.
    struct Stop {
        /// The unique ID for this stop
        ///
        /// Identifies a location: stop/platform, station, entrance/exit, generic node or boarding area (see `location_type`).
        ///
        /// Multiple routes may use the same `id`.
        ///
        /// ## Examples
        /// - `STN_N12` -  Ashburn station
        /// - `STN_D03_F03` - L'Enfant Plaza station
        /// - `PLF_B05_RD_SHADY_GROVE` - Platform at Brookland-CUA on the Red Line to Shady Grove
        ///
        /// ## Notes
        /// - For stations, this ID is typically identical to a ``Station``
        /// - For transfer stations, both `Station` IDs are included. Example: `STN_D03_F03`.
        public var id: GTFS.Identifier<GTFS.Stop>
        
        /// The human readable name of this stop.
        ///
        /// ## Details
        /// - In WMATA GTFS data, this field is always written in all caps.
        /// - May not be suitable for display to users.
        /// - This field does not match the public name of the station.
        ///
        /// ## Example
        ///  `ASHBURN METRORAIL STATION`
        ///
        ///  ## Notes
        ///  While this field is only conditionally required by GTFS, WMATA includes it for all stops. Therefore, it's marked as non-null here.
        public var name: String
        
        /// A short description of the stop.
        ///
        /// ## Notes
        /// Not present on Metrorail stations.
        public var description: String?
        
        /// The latitude and longitude of this stop
        public var location: GTFS.Coordinates
        
        /// Identifies the fare zone for a stop.
        ///
        /// ## Note
        /// I do not know what WMATA uses this field to represent.
        public var zoneID: String
        
        /// The GTFS `location_type` of a stop.
        public enum LocationType: Int {
            /// A location where passengers board or disembark from a transit vehicle. Is called a platform when defined within a `parent_station`
            case platform = 0
            
            /// A physical structure or area that contains one or more platform.
            case station = 1
            
            /// A location where passengers can enter or exit a station from the street.
            case entrance = 2
            
            /// A location within a station, not matching any other `Location`, that may be used to link together pathways.
            ///
            /// ## Notes
            /// Unfortunately, WMATA uses this value for platforms instead of ``GTFS/Stop/Location/platform``. Also used for elevator and escalator landings.
            case genericNode = 3
            
            /// A specific location on a platform, where passengers can board and/or alight vehicles.
            ///
            /// ## Notes
            /// Unused by WMATA.
            case boardingArea = 4
        }
        
        /// If this stop is a Platform, Station, Entrance, or some other type of location.
        public var locationType: LocationType
        
        /// If this stop is location within some other ``GTFS/Stop``
        public var parentStation: GTFS.Identifier<GTFS.Stop>?
        
        /// Indicates whether wheelchair boardings are possible from the location.
        public enum WheelchairBoarding: Int {
            
            // Unused by WMATA.
            case noAccessibilityInformation = 0
            
            // Stop is wheelchair accessible
            case accessible = 1
            
            // Stop is not wheelchair accessible
            case notAccessible = 2
        }
        
        /// Indicates whether wheelchair boardings are possible from the location.
        public var wheelchairBoarding: WheelchairBoarding
        
        /// ``GTFS/Level`` of the location. The same level may be used by multiple unlinked stations.
        public var level: GTFS.Identifier<GTFS.Level>?
        
        public init(id: GTFS.Identifier<GTFS.Stop>, name: String, description: String? = nil, location: GTFS.Coordinates, zoneID: String, locationType: LocationType, parentStation: GTFS.Identifier<GTFS.Stop>? = nil, wheelchairBoarding: WheelchairBoarding, level: GTFS.Identifier<GTFS.Level>? = nil) {
            self.id = id
            self.name = name
            self.description = description
            self.location = location
            self.zoneID = zoneID
            self.locationType = locationType
            self.parentStation = parentStation
            self.wheelchairBoarding = wheelchairBoarding
            self.level = level
        }
    }
}

internal extension GTFS.Stop {
    /// Columns in the SQLite `stops` table
    enum TableColumn {
        static let id = Expression<String>("stop_id")
        static let name = Expression<String>("stop_name")
        static let description = Expression<String?>("stop_desc")
        static let latitude = Expression<Double>("stop_lat")
        static let longitude = Expression<Double>("stop_lon")
        static let zoneID = Expression<String>("zone_id")
        static let locationType = Expression<Int>("location_type")
        static let parentStation = Expression<String?>("parent_station")
        static let wheelchairBoarding = Expression<Int>("wheelchair_boarding")
        static let levelID = Expression<String?>("level_id")
    }
    
    /// Create a ``GTFS/Stop`` from an entry in the `stops` table of SQLite
    static func from(row: Row) throws -> GTFS.Stop {
        guard let locationType = LocationType(rawValue: try row.get(TableColumn.locationType)) else {
            throw GTFS.DatabaseDecodingError.invalidEntry(structureType: GTFS.Stop.self, key: "location_type")
        }
        
        var parentStation: GTFS.Identifier<GTFS.Stop>? = nil
        
        if let parentStationID = try row.get(TableColumn.parentStation) {
            parentStation = GTFS.Identifier<GTFS.Stop>(parentStationID)
        }
        
        guard let wheelchairBoarding = WheelchairBoarding(rawValue:  try row.get(TableColumn.wheelchairBoarding)) else {
            throw GTFS.DatabaseDecodingError.invalidEntry(structureType: GTFS.Stop.self, key: "wheelchair_boarding")
        }
        
        var level: GTFS.Identifier<GTFS.Level>? = nil
        
        if let levelID = try row.get(TableColumn.levelID) {
            level = GTFS.Identifier<GTFS.Level>(levelID)
        }
        
        return GTFS.Stop(
            id: GTFS.Identifier(try row.get(TableColumn.id)),
            name: try row.get(TableColumn.name),
            description: try row.get(TableColumn.description),
            location: GTFS.Coordinates(
                latitude: try row.get(TableColumn.latitude),
                longitude: try row.get(TableColumn.longitude)
            ),
            zoneID: try row.get(TableColumn.zoneID),
            locationType: locationType,
            parentStation: parentStation,
            wheelchairBoarding: wheelchairBoarding,
            level: level
        )
    }
}
