//
//  File.swift
//  
//
//  Created by Emma Foster on 6/23/19.
//
import Foundation

private let decoder = JSONDecoder()

func decode<T: Codable>(data: Data, ofType type: T.Type, completion: @escaping (_ result: T?, _ error: WMATAError?) -> ()) {
    do {
        let decodedData = try decoder.decode(T.self, from: data)
        
        completion(decodedData, nil)
        
        
    } catch {
        do {
            let error = try decoder.decode(WMATAError.self, from: data)
            
            completion(nil, error)
            
        } catch {
            completion(nil, nil)
            
        }
        
    }
    
}
