//
//  GTFSStructure.swift
//  
//
//  Created by Emma on 3/23/24.
//

import Foundation
import SQLite

/// Create an GTFS Structures from a database table
protocol GTFSStructure {
    /// The columns in the table of GTFS Static database for this structure type
    associatedtype TableColumn
    
    /// The actual table in SQLite to pull the data type from
    static var databaseTable: GTFSDatabase.Table { get }
    
    init(row: Row) throws
    
    var id: GTFSIdentifier<Self> { get }
}

extension GTFSStructure {
    /// Create a GTFS structure from an ID. Performs a database query.
    ///
    /// - Parameters:
    ///   - idString: A unique identifier for the structure.
    ///
    ///   - Throws: ``GTFSDatabaseError`` if the GTFS database is unavailable or the database has some other issue
    ///   - Throws: ``GTFSDatabaseQueryError`` if the given ID does not exist in the database
    ///
    /// ```swift
    /// let agency = try GTFSAgency(id: .init("MET"))
    ///
    /// agency.name // "WMATA"
    /// ```
    public init(id: GTFSIdentifier<Self>) throws {
        let database = try GTFSDatabase()
        
        let row = try database.one(Self.self, with: id)
        
        guard let row else {
            throw GTFSDatabaseQueryError.notFound(id, GTFSAgency.databaseTable.sqlTable)
        }
        
        try self.init(row: row)
    }
    
    /// Create a GTFS structure from an ID string. Performs a database query.
    ///
    /// - Parameters:
    ///   - idString: A unique identifier for the structure.
    ///
    ///   - Throws: ``GTFSDatabaseError`` if the GTFS database is unavailable or the database has some other issue
    ///   - Throws: ``GTFSDatabaseQueryError`` if the given Agency ID does not exist in the database
    ///
    /// ```swift
    /// let agency = try GTFSLevel("MET")
    ///
    /// agency.name // "WMATA"
    /// ```
    public init(_ idString: @autoclosure @escaping () -> String) throws {
        try self.init(id: .init(idString()))
    }
    
    /// Create every GTFS structure of this type present in the database. Performs a database query.
    public static func all(with id: GTFSIdentifier<Self>? = nil, in expression: Expression<String>? = nil) throws -> [Self] {
        let database = try GTFSDatabase()
        
        let allRows: AnySequence<Row>
        
        if let id, let expression {
            allRows = try database.all(Self.self, with: id, in: expression)
        } else if let id {
            allRows = try database.all(Self.self, with: id)
        } else {
            allRows = try database.all(Self.self)
        }
        
        return try allRows.map { try Self(row: $0) }
    }
    
    /// Create every GTFS structure of this type present in the database. Performs a database query.
    public static func all(
        _ idString: @autoclosure @escaping () -> String? = nil,
        in expression: Expression<String>? = nil
    ) throws -> [Self] {
        return try Self.all(with: .init(rawValue: idString()), in: expression)
    }
}
