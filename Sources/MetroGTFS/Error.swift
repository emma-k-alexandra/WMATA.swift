//
//  Error.swift
//
//
//  Created by Emma on 11/26/23.
//

import Foundation
import SQLite

public extension GTFS {
    enum DatabaseError: Error {
        case failedToLoadDatabase
        case unableToConnectToDatabase
        case unableToPerformQuery(Table)
        case invalid(Row)
    }
    
    enum DatabaseQueryError<Structure>: Error {
        case notFound(GTFS.Identifier<Structure>)
    }
    
    enum DatabaseDecodingError<T>: Error {
        case invalidEntry(structureType: T.Type, key: String)
    }
}
