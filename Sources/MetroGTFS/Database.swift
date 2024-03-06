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
        func run(query: SQLite.Table) throws -> Row? {
            do {
                return try connection.pluck(query)
            } catch {
                throw GTFS.DatabaseError.unableToPerformQuery(query)
            }
        }
        
        /// Run a database query that returns multiple rows
        func run(query: SQLite.Table) throws -> AnySequence<Row> {
            do {
                return try connection.prepare(query)
            } catch {
                throw GTFS.DatabaseError.unableToPerformQuery(query)
            }
        }
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

/// If a data type can be loaded from a SQLite database
protocol Queryable {
    /// The actual table in SQLite to pull the data type from
    static var databaseTable: GTFS.Database.Table { get }
}

