//
//  EndpointDelegate.swift
//  
//
//  Created by Emma on 11/14/21.
//

import Foundation
import GTFS

public class EndpointDelegate<Parent: Endpoint>: NSObject, URLSessionDownloadDelegate, WMATADecoding {
    func received(_ response: Result<Parent.Response, WMATAError>) {
        assertionFailure("Default EndpointDelegate received response. Override `func received(_ response: Result<Parent.Response, WMATAError>)`")
    }
    
    var sharedContainerIdentifier: String? = nil
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("hello")
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error else {
            return
        }
        
        received(.failure(error.wmataError))
    }
    
    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        guard let error = error else {
            return
        }
        
        received(.failure(error.wmataError))
    }
}

extension EndpointDelegate {
    func loadData(from location: URL) -> Result<Data, WMATAError> {
        do {
            return .success(try Data(contentsOf: location))
        } catch {
            return .failure(.init(
                statusCode: 2,
                message: "Unable to load data from given URL \(location) after download completed. Error: \(error)"
            ))
        }
    }
    
    var session: URLSession {
        let config = URLSessionConfiguration.background(withIdentifier: "com.WMATA.swift.\(UUID())")
        
        config.sharedContainerIdentifier = sharedContainerIdentifier
        
        return URLSession(
            configuration: config,
            delegate: self,
            delegateQueue: nil
        )
    }
}

public class JSONEndpointDelegate<Parent>: EndpointDelegate<Parent>
where
    Parent: Endpoint,
    Parent.Response: Codable
{
    public override func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let data = loadData(from: location)
        
        switch data {
        case let .success(data):
            received(decode(standard: data))
        case let .failure(error):
            received(.failure(error))
        }
    }
}

public class GTFSEndpointDelegate<Parent>: EndpointDelegate<Parent>
where
    Parent: Endpoint,
    Parent.Response == TransitRealtime_FeedMessage
{
    public override func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        switch loadData(from: location) {
        case let .success(data):
            received(decode(gtfs: data))
        case let .failure(error):
            received(.failure(error))
        }
    }
}
