//
//  CSV.swift
//
//
//  Created by Emma on 11/25/23.
//

import Foundation
import SwiftCSV

public func loadCSV() throws {
    let csv = try CSV<Named>(
        name: "stops",
        extension: "txt",
        bundle: .module
    )
    
    guard let csv else { return }
    
    try csv.enumerateAsDict { row in
        print(row)
    }
}
