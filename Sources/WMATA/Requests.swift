//
//  Requests.swift
//  
//
//  Created by Emma K Alexandra on 6/16/19.
//
import Foundation

/// Indicates the implementors can send an HTTP request
protocol Requester {}

extension Requester {
    /// Default implementation for sending an HTTP request.
    ///
    /// - parameter request: The URLRequest to send
    /// - parameter completion: Completion handler to receive output of request.
    func request(with request: URLRequest, andSession session: URLSession, completion: @escaping (Result<Data, WMATAError>) -> ()) {
        
        session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                if let populatedError = error {
                    completion(.failure(populatedError.toWMATAError()))
                    
                } else {
                    completion(.failure(WMATAError(statusCode: 0, message: "Neither data or error are present from request.")))
                    
                }
                
                return
            }
            
            completion(.success(populatedData))
            
        }.resume()
        
    }
    
}

/// Indicates the implementor can request and deserialize data
protocol Fetcher: Requester, Deserializer {}

extension Fetcher {
    /// Default implementation for requesting and deserializing data
    func fetch<T: Decodable>(with urlRequest: URLRequest, andSession session: URLSession, completion: @escaping (Result<T, WMATAError>) -> ()) {
        request(with: urlRequest, andSession: session) { (result) in
            switch result {
            case .success(let data):
                completion(self.deserialize(data))
                
            case .failure(let error):
                completion(.failure(error))
                
            }
            
        }
        
    }
    
}

/// Incidates the implmentor can build a URLRequest
protocol RequestBuilder {}

extension RequestBuilder {
    /// Default implemention of buildRequest.
    ///
    /// - parameter url: URL to request
    /// - parameter queryItems: Query parameters for request
    /// - returns: A URLRequest
    func buildRequest(fromUrl url: String, andQueryItems queryItems: [(String, String)], withApiKey apiKey: String) -> URLRequest {
        var urlComponents = URLComponents(string: url)!
        
        urlComponents.queryItems = queryItems.compactMap { URLQueryItem(name: $0, value: $1) }
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(apiKey, forHTTPHeaderField: "api_key")
        
        return request
        
    }
    
}
