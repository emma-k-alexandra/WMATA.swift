//
//  Delegate.swift
//  
//
//  Created by Emma K Alexandra on 11/26/19.
//

import Foundation

public protocol WMATADelegate: URLSessionDataDelegate {
    func received<T>(_ data: T) where T: Codable
    
}

extension WMATADelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
    }
    
}
