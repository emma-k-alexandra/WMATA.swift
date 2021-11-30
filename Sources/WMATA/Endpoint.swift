//
//  Endpoint.swift
//  
//
//  Created by Emma on 11/4/21.
//

import Foundation
import Combine
import GTFS

/// A WMATA API endpoint
///
/// Used to make requests and receive responses from an API. Endpoints are available in ``Rail`` for MetroRail and ``Bus`` for MetroBus.
public protocol Endpoint: WMATADecoding, Hashable {
    /// The response WMATA sends back when calling this endpoint
    associatedtype Response
    
    /// WMATA API Key for this request
    var key: APIKey { get }
    
    /// Send an HTTP request to this endpoint
    func request(with session: URLSession, completion: @escaping (_ result: Result<Response, WMATAError>) -> Void)
    
    /// Send an async HTTP request to this endpoint
    @available(macOS 12, iOS 15, watchOS 7, tvOS 15, *)
    func request(with session: URLSession) async -> Result<Response, WMATAError>
    
    /// Send a background HTTP request to the endpoint.
    func backgroundRequest()
    
    /// Send an HTTP request to this endpoint and receive a Combine Publisher with the response
    func publisher(with session: URLSession) -> AnyPublisher<Response, WMATAError>
    
    /// The URL this request is sent to
    ///
    /// > Note: You generally will not need this in typical usage
    var url: URLComponents { get }
    
    /// The URL query items to pass along with the URL for this endpoint
    ///
    /// > Note: You will not need this in typical usage
    func queryItems() -> [URLQueryItem?]
}

extension Endpoint {
    /// Generate a URL that includes this endpoint's URL query items
    func url(with queryItems: [URLQueryItem?]) -> URL? {
        var components = self.url
        components.queryItems = queryItems.withoutNil()
        
        return components.url
    }
    
    /// Generate a request that includes url, query items and API key for this endpoint.
    func urlRequest() -> URLRequest? {
        guard let url = url(with: queryItems()) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "api_key")
        
        return request
    }
}

/// An endpoint that returns JSON data.
///
/// WMATA's Standard API returns JSON.
public protocol JSONEndpoint: Endpoint where Response: Codable {
    /// Delegate to send background requests to
    var delegate: JSONEndpointDelegate<Self>? { get set }
}

public extension JSONEndpoint {
    func backgroundRequest() {
        guard let delegate = delegate else {
            preconditionFailure("Request sent to delegate without delegate defined on endpoint \(String(describing: self))")
        }
        
        guard let request = urlRequest() else {
            delegate.received(.failure(.unableToCreateRequest(endpoint: String(describing: self))))
            return
        }
        
        delegate.session.downloadTask(with: request).resume()
    }
    
    func request(with session: URLSession = .shared, completion: @escaping (_ result: Result<Response, WMATAError>) -> Void) {
        guard let request = urlRequest() else {
            completion(.failure(.unableToCreateRequest(endpoint: String(describing: self))))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestEnded(underlyingError: error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.requestFailed(response: response)))
                return
            }
            
            completion(createResult((data, response)).flatMap { decode(standard: $0) })
        }.resume()
    }
    
    @available(macOS 12, iOS 15, watchOS 7, tvOS 15, *)
    func request(with session: URLSession = .shared) async -> Result<Response, WMATAError> {
        guard let request = urlRequest() else {
            return .failure(.unableToCreateRequest(endpoint: String(describing: self)))
        }
        
        do {
            let response = try await session.data(for: request)
            
            return createResult(response).flatMap { decode(standard: $0) }
        } catch {
            return .failure(.requestEnded(underlyingError: error))
        }
    }
    
    func publisher(with session: URLSession = .shared) -> AnyPublisher<Response, WMATAError> {
        guard let request = urlRequest() else {
            return Fail(
                error: .unableToCreateRequest(endpoint: String(describing: self))
            ).eraseToAnyPublisher()
        }
        
        return session
            .dataTaskPublisher(for: request)
            .tryMap { try createResult($0).get() }
            .decode(type: Response.self, decoder: WMATAJSONDecoder())
            .mapError { error in
                if let error = error as? WMATAError {
                    return error
                }
                
                return .requestEnded(underlyingError: error)
            }
            .eraseToAnyPublisher()
    }
}

/// An endpoint that returns GTFS Protocol Buffer data.
///
/// WMATA's GTFS endpoints return GTFS Protocol Buffer data.
public protocol GTFSEndpoint: Endpoint where Response == TransitRealtime_FeedMessage {
    /// Delegate to send background requests to
    var delegate: GTFSEndpointDelegate<Self>? { get set }
}

// GTFS-RT
public extension GTFSEndpoint {
    func queryItems() -> [URLQueryItem?] {
        []
    }
    
    func backgroundRequest() {
        guard let delegate = delegate else {
            preconditionFailure("Request sent to delegate without delegate defined on endpoint \(String(describing: self))")
        }
        
        guard let request = urlRequest() else {
            delegate.received(.failure(.unableToCreateRequest(endpoint: String(describing: self))))
            return
        }
        
        delegate.session.downloadTask(with: request).resume()
    }
    
    func request(with session: URLSession = .shared, completion: @escaping (Result<Response, WMATAError>) -> Void) {
        guard let request = urlRequest() else {
            completion(.failure(.unableToCreateRequest(endpoint: String(describing: self))))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestEnded(underlyingError: error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.requestFailed(response: response)))
                return
            }
            
            completion(createResult((data, response)).flatMap { decode(gtfs: $0) })
        }.resume()
    }
    
    @available(macOS 12, iOS 15, watchOS 7, tvOS 15, *)
    func request(with session: URLSession = .shared) async -> Result<Response, WMATAError> {
        guard let request = urlRequest() else {
            return .failure(.unableToCreateRequest(endpoint: String(describing: self)))
        }
        
        do {
            let response = try await session.data(for: request)
            
            return createResult(response).flatMap { decode(gtfs: $0) }
        } catch {
            return .failure(.requestEnded(underlyingError: error))
        }
    }
    
    func publisher(with session: URLSession = .shared) -> AnyPublisher<Response, WMATAError> {
        guard let request = urlRequest() else {
            return Fail(
                error: .unableToCreateRequest(endpoint: String(describing: self))
            ).eraseToAnyPublisher()
        }
            
        return session
            .dataTaskPublisher(for: request)
            .tryMap { try TransitRealtime_FeedMessage(serializedData: try createResult($0).get()) }
            .mapError { error in
                if let error = error as? WMATAError {
                    return error
                }
                
                return .requestEnded(underlyingError: error)
            }
            .eraseToAnyPublisher()
    }
}

/// Create Result object from response data
func createResult(_ response: (data: Data, response: URLResponse?)) -> Result<Data, WMATAError> {
    if let httpResponse = response.response as? HTTPURLResponse,
       httpResponse.statusCode != 200 {
        print("failed", response.data, httpResponse)
        return .failure(.init(response.data, httpResponse))
    }
    
    print("response", response.response, "data", String(data: response.data, encoding: .utf8))
    
    return .success(response.data)
}

func createResult(_ response: (data: Data, response: URLResponse)) -> Result<Data, WMATAError> {
    createResult((response.data, .some(response.response)))
}

extension WMATAError {
    init(_ data: Data, _ response: HTTPURLResponse) {
        let message: String
        
        do {
            message = try JSONDecoder().decode(WMATAError.Message.self, from: data).message
        } catch {
            self = .errorDecodingErrorMessage(underlyingError: error)
            return
        }
        
        switch response.statusCode {
        case 429:
            self = .rateLimitExceeded(message: message)
        case 401:
            self = .accessDenied(message: message)
        case 400:
            self = .badRequest(message: message)
        default:
            self = .errorResponse(message: message)
        }
    }
}
