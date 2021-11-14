//
//  Endpoint.swift
//  
//
//  Created by Emma on 11/4/21.
//

import Foundation
import Combine
import GTFS

public protocol Endpoint: WMATADecoding {
    associatedtype Response
    
    /// Endpoint URL for the Request
    var url: URLComponents { get }
    
    /// WMATA API Key for this request
    var key: APIKey { get }
    
    var delegate: EndpointDelegate<Self>? { get set }
    
    func queryItems() -> [URLQueryItem?]
    
    func request(with session: URLSession, completion: @escaping (_ result: Result<Response, WMATAError>) -> Void)
    
    func request()
    
    func publisher(with session: URLSession) -> AnyPublisher<Response, WMATAError>
}

extension Endpoint {
    public func queryItems() -> [URLQueryItem?] {
        []
    }

// TODO: Do I need this?
//    func request(with session: URLSession = .shared, completion: @escaping (_ result: Result<Response, WMATAError>) -> Void) {
//        request(with: session, completion: completion)
//    }
//
//    func publisher(with session: URLSession = .shared) -> AnyPublisher<Response, WMATAError> {
//        publisher(with: session)
//    }
    
    internal func url(with queryItems: [URLQueryItem?]) -> URL? {
        var components = self.url
        components.queryItems = queryItems.withoutNil()
        
        return components.url
    }
    
    internal func urlRequest() -> URLRequest? {
        guard let url = url(with: queryItems()) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "api_key")
        
        return request
    }
}

public extension Endpoint {
    func request() {
        guard let delegate = delegate else {
            assertionFailure("Request sent to delegate without delegate defined on endpoint \(String(describing: self))")
            return
        }
        
        guard let request = urlRequest() else {
            delegate.received(
                .failure(.init(
                    statusCode: 1,
                    message: "Unable to create URLRequest for endpoint \(String(describing: self))"
                ))
            )
            return
        }
        
        delegate.session.downloadTask(with: request).resume()
    }
}

// Standard API
public extension Endpoint where Response: Codable {
    // TODO: Allow rethrows
    func request(with session: URLSession = .shared, completion: @escaping (_ result: Result<Response, WMATAError>) -> Void) {
        guard let request = urlRequest() else {
            completion(.failure(.init(statusCode: 1, message: "Unable to create URLRequest for endpoint \(String(describing: self))")))
            return
        }
        
        session.dataTask(with: request) { data, _response, error in
            guard let data = data else {
                guard let error = error else {
                    completion(.failure(.init(statusCode: 3, message: "Neither data or error are present in response")))
                    return
                }
                
                completion(.failure(error.wmataError))
                return
            }
            
            completion(decode(standard: data))
        }.resume()
    }
    
    func publisher(with session: URLSession = .shared) -> AnyPublisher<Response, WMATAError> {
        guard let request = urlRequest() else {
            return Fail(
                error: WMATAError(
                    statusCode: 1,
                    message: "Unable to create URLRequest for endpoint \(String(describing: self))"
                )
            ).eraseToAnyPublisher()
        }
        
        return session
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Response.self, decoder: WMATAJSONDecoder())
            .mapError { $0.wmataError }
            .eraseToAnyPublisher()
    }
}

// GTFS-RT
public extension Endpoint where Response == TransitRealtime_FeedMessage {
    func request(with session: URLSession = .shared, completion: @escaping (Result<Response, WMATAError>) -> Void) {
        guard let request = urlRequest() else {
            completion(.failure(.init(statusCode: 1, message: "Unable to create URLRequest for endpoint \(String(describing: self))")))
            return
        }
        
        session.dataTask(with: request) { data, _response, error in
            guard let data = data else {
                guard let error = error else {
                    completion(.failure(.init(statusCode: 3, message: "Neither data or error are present in response")))
                    return
                }
                
                completion(.failure(error.wmataError))
                return
            }
            
            let decodedData: Result<TransitRealtime_FeedMessage, WMATAError> = decode(gtfs: data)
            
            switch decodedData {
            case let .success(response):
                completion(.success(response))
            case let .failure(decodeError):
                completion(.failure(decodeError))
            }
        }.resume()
    }
    
    func publisher(with session: URLSession = .shared) -> AnyPublisher<Response, WMATAError> {
        guard let request = urlRequest() else {
            return Fail(
                error: WMATAError(
                    statusCode: 1,
                    message: "Unable to create URLRequest for endpoint \(String(describing: self))"
                )
            ).eraseToAnyPublisher()
            
        }
            
        return session
            .dataTaskPublisher(for: request)
            .tryMap { try TransitRealtime_FeedMessage(serializedData: $0.data) }
            .mapError { $0.wmataError }
            .eraseToAnyPublisher()
    }
}

public protocol OnlyJSONEndpoint: Endpoint {}

public extension OnlyJSONEndpoint {
    func queryItems() -> [URLQueryItem?] {
        [URLQueryItem(name: "contentType", value: "json")]
    }
}
