//
//  Database.swift
//
//
//  Created by Emma on 11/26/23.
//

import Foundation
import SQLite

extension GTFS {
    /// The GTFS Static Database. Used to perform queries on the GTFS Static Database.
    struct Database {
        private let connection: Connection
        
        /// Create a new GTFS Database. If there is not currently an open connection to the database, create one.
        init() throws {
            if let connection = GTFS.Database.shared {
                self.connection = connection
                
                return
            }
            
            let connection: Connection
            
            do {
                connection = try GTFS.Database.connection()
            } catch {
                throw GTFS.DatabaseError.unableToConnectToDatabase
            }
            
            GTFS.Database.shared = connection
            
            self.connection = connection
        }
        
        /// Run a database query that only returns one row
        private func run(query: SQLite.Table) throws -> Row? {
            do {
                return try connection.pluck(query)
            } catch {
                throw GTFS.DatabaseError.unableToPerformQuery(query)
            }
        }
        
        /// Run a database query that returns multiple rows
        private func run(query: SQLite.Table) throws -> AnySequence<Row> {
            do {
                return try connection.prepare(query)
            } catch {
                throw GTFS.DatabaseError.unableToPerformQuery(query)
            }
        }
        
//        /// Fetch all stops from the GTFS Static Stops table
//        func stops() throws -> AnySequence<Row> {
//            return try run(query: Tables.stops)
//            
//        }
//        
//        /// Fetch a stop with the given `id` from the GTFS Static Stops table
//        func stop(with id: GTFS.Identifier<GTFS.Stop>) throws -> Row? {
//            return try run(query: Tables.stops.where(GTFS.Stop.TableColumn.id == id.string))
//        }
//        
//        /// Fetch all GTFS Stops with the given Parent Station.
//        ///
//        /// [More info on Parent Stations](https://developers.google.com/transit/gtfs/reference#stopstxt)
//        func stops(parentStation id: GTFS.Identifier<GTFS.Stop>) throws -> AnySequence<Row> {
//            return try run(query: Tables.stops.where(GTFS.Stop.TableColumn.parentStation == id.string))
//        }
//        
//        /// Fetch all levels from the GTFS Static Levels table
//        func levels() throws -> AnySequence<Row> {
//            return try run(query: Tables.levels)
//        }
    }
}

extension GTFS.Database {
    /// Get all GTFS Structures of the given type from the GTFS Database
    func all<Structure: Queryable>(_ structure: Structure.Type) throws -> AnySequence<Row> {
        return try run(query: structure.databaseTable.sqlTable)
    }
    
    /// Get all GTFS Structures of the given type with the given `id` in the given `column`. Defaults to using the primary key column.
    func all<Structure: Queryable>(
        _ structure: Structure.Type,
        with id: GTFS.Identifier<Structure>,
        in column: SQLite.Expression<String> = Structure.databaseTable.primaryKeyColumn
    ) throws -> AnySequence<Row> {
        return try run(query: structure.databaseTable.sqlTable.where(column == id.string))
    }
    
    /// Get all GTFS Structures of the given type with the given `id` in the given `column`.
    func all<Structure: Queryable>(
        _ structure: Structure.Type,
        with id: GTFS.Identifier<Structure>,
        in column: SQLite.Expression<String?>
    ) throws -> AnySequence<Row> {
        return try run(query: structure.databaseTable.sqlTable.where(column == id.string))
    }

    
    /// Get a single structure of the given type with the given `id` in the given `column`. Defaults to using the primary key column.
    func one<Structure: Queryable>(
        _ structure: Structure.Type,
        with id: GTFS.Identifier<Structure>,
        in column: SQLite.Expression<String> = Structure.databaseTable.primaryKeyColumn
    ) throws -> Row? {
        return try run(query: structure.databaseTable.sqlTable.where(column == id.string))
    }
}

extension GTFS.Database {
    /// The global shares connection to the GTFS database
    private static var shared: Connection?
    
    /// Create a new connection to the MetroGTFS SQLite database
    private static func connection() throws -> Connection  {
        let path = Bundle.module.path(forResource: "MetroGTFS", ofType: "sqlite3")
        
        guard let path else {
            throw GTFS.DatabaseError.failedToLoadDatabase
        }
        
        let connection = try Connection(path, readonly: true)
        
        return connection
    }
}

extension GTFS.Database {
    /// A SQLite database table and the column it's primary key is in
    struct Table {
        let sqlTable: SQLite.Table
        let primaryKeyColumn: SQLite.Expression<String>
    }
}

protocol Queryable {
    static var databaseTable: GTFS.Database.Table { get }
}

