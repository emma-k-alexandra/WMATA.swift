//
//  Agency.swift
//
//
//  Created by Emma on 3/23/24.
//

import Foundation
import SQLite

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
    
    /// Create an Agency from an Agency ID. Performs a database query.
    ///
    /// - Parameters:
    ///   - idString: A unique identifier for an agency. For WMATA, this is `MET`.
    ///
    ///   - Throws: ``GTFSDatabaseError`` if the GTFS database is unavailable or the database has some other issue
    ///   - Throws: ``GTFSDatabaseQueryError`` if the given Agency ID does not exist in the database
    ///
    /// [More on Agencies](https://gtfs.org/schedule/reference/#agencytxt)
    ///
    /// ```swift
    /// let agency = try GTFSAgency(id: .init("MET"))
    ///
    /// agency.name // "WMATA"
    /// ```
    public init(id: GTFSIdentifier<GTFSAgency>) throws {
        let database = try GTFSDatabase()
        
        let agencyRow = try database.one(GTFSAgency.self, with: id)
        
        guard let agencyRow else {
            throw GTFSDatabaseQueryError.notFound(id, GTFSAgency.databaseTable.sqlTable)
        }
        
        try self.init(row: agencyRow)
    }
    
    /// Create an Agency from an Agency ID string. Performs a database query.
    ///
    /// - Parameters:
    ///   - idString: A unique identifier for an agency. For WMATA, this is `MET`.
    ///
    ///   - Throws: ``GTFSDatabaseError`` if the GTFS database is unavailable or the database has some other issue
    ///   - Throws: ``GTFSDatabaseQueryError`` if the given Agency ID does not exist in the database
    ///
    /// [More on Agencies](https://gtfs.org/schedule/reference/#agencytxt)
    ///
    /// ```swift
    /// let agency = try GTFSAgency("MET")
    ///
    /// agency.name // "WMATA"
    /// ```
    public init(_ idString: @autoclosure @escaping () -> String) throws {
        try self.init(id: .init(idString()))
    }
    
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
}

extension GTFSAgency {
    /// Columns in thr GTFS Static agency datatable table
    enum TableColumn {
        static let id = Expression<String>("agency_id")
        static let name = Expression<String>("agency_name")
        static let url = Expression<URL>("agency_url")
        static let timeZone = Expression<String>("agency_timezone")
        static let language = Expression<String>("agency_lang")
        static let phone = Expression<String>("agency_phone")
        static let fareURL = Expression<URL>("agency_fare_url")
    }
}

extension GTFSAgency: Queryable {
    static let databaseTable = GTFSDatabase.Table(sqlTable: SQLite.Table("agency"), primaryKeyColumn: GTFSAgency.TableColumn.id)
}
