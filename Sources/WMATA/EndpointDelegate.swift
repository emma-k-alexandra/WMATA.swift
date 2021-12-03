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
        assertionFailure("Abstract EndpointDelegate received response. Override `func received(_ response: Result<Parent.Response, WMATAError>)`")
    }
    
    var sharedContainerIdentifier: String? = nil
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        assertionFailure("You must override `.urlSession(_:downloadTask:didFinishDownloadingTo:)` if not using JSONEndpointDelegate or GTFSEndpointDelegate")
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error else {
            return
        }
        
        received(.failure(.backgroundSessionFailure(underlyingError: error)))
    }
    
    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        guard let error = error else {
            return
        }
        
        received(.failure(.backgroundSessionBecameInvalid(underlyingError: error)))
    }
}

extension EndpointDelegate {
    func loadData(from location: URL) -> Result<Data, WMATAError> {
        do {
            return .success(try Data(contentsOf: location))
        } catch {
            return .failure(.unableToLoadBackgroundFile(location: location, underlyingError: error))
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

public class JSONEndpointDelegate<Parent: JSONEndpoint>: EndpointDelegate<Parent> {
    public override func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        received(loadData(from: location)
            .flatMap { createResult(($0, downloadTask.response)) }
            .flatMap { decode(standard: $0) }
        )
    }
}

public class GTFSEndpointDelegate<Parent: GTFSEndpoint>: EndpointDelegate<Parent> {
    public override func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        received(loadData(from: location)
            .flatMap { createResult(($0, downloadTask.response)) }
            .flatMap { decode(gtfs: $0) }
        )
    }
}
