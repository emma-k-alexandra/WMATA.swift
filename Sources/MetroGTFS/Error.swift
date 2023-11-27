//
//  Error.swift
//
//
//  Created by Emma on 11/26/23.
//

import Foundation

public extension GTFS {
    enum DatabaseError: Error {
        case failedToLoadDatabase
    }
    
    enum DatabaseDecodingError<T>: Error {
        case invalidEntry(structureType: T.Type, key: String)
    }
}
