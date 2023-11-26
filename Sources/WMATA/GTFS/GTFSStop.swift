//
//  GTFSStop.swift
//
//
//  Created by Emma on 11/25/23.
//

import Foundation

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
        var id: WMATAIdentifier<Self>
        
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
        var name: String
        
        /// A short description of the stop.
        ///
        /// ## Notes
        /// Not present on Metrorail stations.
        var description: String?
        
        /// The latitude and longitude of this stop
        var location: WMATALocation.Coordinates
        
        /// Identifies the fare zone for a stop.
        ///
        /// ## Note
        /// I do not know what WMATA uses this field to represent.
        var zoneID: Int
        
        /// The GTFS `location_type` of a stop.
        public enum Location: Int {
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
        var locationType: Location
        
        /// If this stop is location within some other ``GTFS/Stop``
        var parentStation: WMATAIdentifier<Self>?
        
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
        var wheelchairBoarding: WheelchairBoarding
        
        /// ``GTFS/Level`` of the location. The same level may be used by multiple unlinked stations.
        var level: WMATAIdentifier<GTFS.Level>?
    }
}


