//
//  GTFSLevel.swift
//
//
//  Created by Emma on 11/25/23.
//

import Foundation
import SQLite

/// A [GTFS Level](https://gtfs.org/schedule/reference/#levelstxt). Describes the different physical levels and floors in a station. Can be used with pathways to navigate stations.
///
/// ```swift
/// let level = try GTFSLevel("B05_L1")
///
/// level.name // "Mezzanine"
/// ```
public struct GTFSLevel: Equatable, Hashable, Codable {
    /// A unique identifer for the level.
    public var id: GTFSIdentifier<GTFSLevel>
    
    /// Numeric index of the level that indicates its relative position.
    ///
    /// For WMATA, these are integers between -3 and 2.
    ///
    /// Ground level should have index 0, with levels above ground indicated by positive indices and levels below ground by negative indices.
    public var index: Int
    
    /// Name of the level as seen by the rider inside the building or station.
    public var name: String
    
    /// Create a new GTFS Level by providing all of it's fields
    public init(id: GTFSIdentifier<GTFSLevel>, index: Int, name: String) {
        self.id = id
        self.index = index
        self.name = name
    }
    
    /// Create a Level from a Level ID. Performs a database query.
    ///
    /// - Parameters:
    ///   - id: A unique indentifer for a level. Typically is a station code + a floor identifier. Example: `.init("B05_L1")`
    ///
    ///   - Throws: `GTFSDatabaseError` if the GTFS database is unavailable or the database has some other issue
    ///   - Throws: `GTFSDatabaseQueryError` if the given level is not in the database
    ///
    /// [More on Level IDs](https://developers.google.com/transit/gtfs/reference#levelstxt)
    ///
    /// ```swift
    /// let level = try GTFSLevel(.init("B05_L1"))
    ///
    /// level.name // "Mezzanine"
    /// ```
    public init(id: GTFSIdentifier<GTFSLevel>) throws {
        let database = try GTFSDatabase()
        
        let levelRow = try database.one(GTFSLevel.self, with: id)
        
        guard let levelRow else {
            throw GTFSDatabaseQueryError.notFound(id, GTFSLevel.databaseTable.sqlTable)
        }
        
        try self.init(row: levelRow)
    }
    
    /// Create a Level from a Level ID string. Performs a database query.
    ///
    /// - Parameters:
    ///   - idString: A unique indentifer for a level. Typically is a station code + a floor identifier. Example: `B05_L1`
    ///
    ///   - Throws: `GTFSDatabaseError` if the GTFS database is unavailable or the database has some other issue
    ///   - Throws: `GTFSDatabaseQueryError` if the given level ID is not in the database
    ///
    /// [More on Levels](https://gtfs.org/schedule/reference/#levelstxt)
    ///
    /// ```swift
    /// let level = try GTFSLevel("B05_L1")
    ///
    /// level.name // "Mezzanine"
    /// ```
    public init(_ idString: @autoclosure @escaping () -> String) throws {
        try self.init(id: .init(idString()))
    }
    
    /// Create a Level from a database row from the `levels` table
    init(row: Row) throws {
        self.id = GTFSIdentifier(try row.get(TableColumn.id))
        do {
            self.index = Int(try row.get(TableColumn.index))
            self.name = try row.get(TableColumn.name)
        } catch {
            throw GTFSDatabaseError.invalid(row)
        }
    }
}

extension GTFSLevel {
    /// Columns in the GTFS Static levels database table
    enum TableColumn {
        static let id = Expression<String>("level_id")
        static let index = Expression<Double>("level_index")
        static let name = Expression<String>("level_name")
    }
}

extension GTFSLevel: Queryable {
    static let databaseTable = GTFSDatabase.Table(sqlTable: SQLite.Table("levels"), primaryKeyColumn: GTFSLevel.TableColumn.id)
}
