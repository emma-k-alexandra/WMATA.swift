//
//  Deserialize.swift
//  
//
//  Created by Emma K Alexandra on 11/1/19.
//

import Foundation

/// Incidates the implementors can deserialize data
protocol Deserializer {}

extension Deserializer {
    /// Default implemention for deserialize.
    ///
    /// - parameter data: Data to deserialize
    /// - returns: Result container the deserialized data, or an error
    func deserialize<T: Decodable>(_ data: Data) -> Result<T, WMATAError> {
        do {
            return .success(try JSONDecoder().decode(T.self, from: data))
            
        } catch {
            let originalError = error
            
            do {
                return .failure(try JSONDecoder().decode(WMATAError.self, from: data))
                
            } catch {
                return .failure(originalError.toWMATAError())
                
            }
            
        }
        
    }
    
}
