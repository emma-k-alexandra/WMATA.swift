//
//  Agency.swift
//
//
//  Created by Emma on 3/23/24.
//

import Foundation
import SQLite

/// A [GTFS Agency](https://gtfs.org/schedule/reference/#agencytxt). Describes the different physical levels and floors in a station. Can be used with pathways to navigate stations.
///
/// ```swift
/// let level = try GTFSAgency("MET")
///
/// level.name // "WMATA"
/// ```
public struct GTFSAgency: Equatable, Hashable, Codable {
    /// A unique identifier for this agency. `MET` for WMATA.
    public var id: GTFSIdentifier<GTFSAgency>
    
    /// The user-friendly name of the agency. `WMATA` for WMATA.
    public var name: String
    
    /// The URL of the agency's public website. `https://wmata.com` for WMATA.
    public var url: URL
    
    /// The time zone ID the agency operates in. `America/New_York` for WMATA.
    public var timeZone: TimeZone
    
    /// The language ID the agency primarily operates in. `en` for WMATA.
    public var language: String
    
    /// The phone number of the agency. `202-637-7000` for WMATA.
    public var phone: String
    
    /// The URL of the agency's public website where fare information is available. `https://www.wmata.com/fares/` for WMATA.
    public var fareURL: URL
    
    /// Create a new GTFS Agency by providing all of it's fields
    public init(id: GTFSIdentifier<GTFSAgency>, name: String, url: URL, timeZone: TimeZone, language: String, phone: String, fareURL: URL) {
        self.id = id
        self.name = name
        self.url = url
        self.timeZone = timeZone
        self.language = language
        self.phone = phone
        self.fareURL = fareURL
    }
}

extension GTFSAgency: GTFSStructure {
    /// Create an Agency from a database row in the `agency` table
    init(row: Row) throws {
        self.id = GTFSIdentifier(try row.get(TableColumn.id))
        
        do {
            self.name = try row.get(TableColumn.name)
            self.url = try row.get(TableColumn.url)
            
            let timeZone = TimeZone(identifier: try row.get(TableColumn.timeZone))
            guard let timeZone else {
                throw GTFSDatabaseDecodingError.invalidEntry(structureType: GTFSAgency.self, key: "timeZone")
            }
            
            self.timeZone = timeZone
            self.language = try row.get(TableColumn.language)
            self.phone = try row.get(TableColumn.phone)
            self.fareURL = try row.get(TableColumn.fareURL)
        } catch {
            throw GTFSDatabaseError.invalid(row)
        }
    }
    
    /// Columns in the GTFS Static agency datatable table
    enum TableColumn {
        static let id = Expression<String>("agency_id")
        static let name = Expression<String>("agency_name")
        static let url = Expression<URL>("agency_url")
        static let timeZone = Expression<String>("agency_timezone")
        static let language = Expression<String>("agency_lang")
        static let phone = Expression<String>("agency_phone")
        static let fareURL = Expression<URL>("agency_fare_url")
    }
    
    static let databaseTable = GTFSDatabase.Table(sqlTable: SQLite.Table("agency"), primaryKeyColumn: GTFSAgency.TableColumn.id)
}
