//
//  Database.swift
//
//
//  Created by Emma on 11/26/23.
//

import Foundation
import SQLite

extension GTFS {
    enum Database {
        /// Create a new connection to the MetroGTFS SQLite database
        static func connection() throws -> Connection  {
            let path = Bundle.module.path(forResource: "MetroGTFS", ofType: "sqlite3")
            
            guard let path else {
                throw GTFS.DatabaseError.failedToLoadDatabase
            }
            
            let connection = try Connection(path, readonly: true)
            
            return connection
        }
        
        /// Fetch all stops from the given SQLite database
        static func stops(from database: Connection) throws -> AnySequence<Row> {
            return try database.prepare(Table("stops"))
        }
    }
}

