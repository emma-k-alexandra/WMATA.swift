//
//  EndpointDelegate.swift
//  
//
//  Created by Emma on 11/14/21.
//

import Foundation
import GTFS

/// Base delegate for receiving background responses from an ``Endpoint``.
///
/// This class is not indented for direct use. Instead, subclass ``JSONEndpointDelegate`` or ``GTFSEndpointDelegate``.
open class EndpointDelegate<Parent: Endpoint>: NSObject, URLSessionDownloadDelegate, WMATADecoding {
    
    /// Handle a response from a background request. Override this in your own delegate.
    open func received(_ response: Result<Parent.Response, WMATAError>) {
        assertionFailure("Base EndpointDelegate received response. Override `func received(_ response: Result<Parent.Response, WMATAError>)`")
    }
    
    /// An indentifier used when running in an app extension.
    ///
    /// Check <doc:BackgroundRequests> and [Apple's documentation](https://developer.apple.com/documentation/foundation/urlsessionconfiguration/1409450-sharedcontaineridentifier) for more details.
    open var sharedContainerIdentifier: String? = nil
    
    /// Abstract URLSessionDownloadTask handler
    ///
    /// You will only need to override this method if you are not using ``JSONEndpointDelegate`` or ``GTFSEndpointDelegate``.
    open func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        assertionFailure("You must override `.urlSession(_:downloadTask:didFinishDownloadingTo:)` if not using JSONEndpointDelegate or GTFSEndpointDelegate")
    }
    
    /// Calls ``received(_:)`` on an error.
    ///
    /// You likely will not need to override this method in typical usage.
    open func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error else {
            return
        }
        
        received(.failure(.backgroundSessionFailure(underlyingError: error)))
    }
    
    /// Calls ``received(_:)`` on an error.
    ///
    /// You likely will not need to override this method in typical usage.
    open func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        guard let error = error else {
            return
        }
        
        received(.failure(.backgroundSessionBecameInvalid(underlyingError: error)))
    }
}

extension EndpointDelegate {
    /// Loads data from a file into `Data`.
    func loadData(from location: URL) -> Result<Data, WMATAError> {
        do {
            return .success(try Data(contentsOf: location))
        } catch {
            return .failure(.unableToLoadBackgroundFile(location: location, underlyingError: error))
        }
    }
    
    /// The URLSession used in the background.
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

/// A delegate for Standard API endpoints.
///
/// To make your own delegate, sublcass this and override ``EndpointDelegate/received(_:)``.
open class JSONEndpointDelegate<Parent: JSONEndpoint>: EndpointDelegate<Parent> {
    open override func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        received(loadData(from: location)
            .flatMap { createResult(($0, downloadTask.response)) }
            .flatMap { decode(standard: $0) }
        )
    }
}

/// A delegate for GTFS API endpoints.
///
/// To make your own delegate, sublcass this and override ``EndpointDelegate/received(_:)``.
open class GTFSEndpointDelegate<Parent: GTFSEndpoint>: EndpointDelegate<Parent> {
    open override func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        received(loadData(from: location)
            .flatMap { createResult(($0, downloadTask.response)) }
            .flatMap { decode(gtfs: $0) }
        )
    }
}
