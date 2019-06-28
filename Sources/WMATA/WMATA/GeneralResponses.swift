//
//  GeneralResponses.swift
//  
//
//  Created by Emma Foster on 6/23/19.
//

public struct WMATAError: Codable {
    let statusCode: Int
    let message: String
    
}

extension Error {
    func toWMATAError() -> WMATAError {
        return WMATAError(statusCode: 0, message: self.localizedDescription)
    }
    
}
