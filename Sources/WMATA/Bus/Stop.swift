//
//  Stop.swift
//  
//
//  Created by Emma Foster on 6/17/19.
//

import Foundation

/// Information relating to a specific MetroBus stop
public class Stop {
    /// URLs of WMATA endpoints relating to Stops
    enum Urls: String {
        case nextBuses = "https://api.wmata.com/NextBusService.svc/json/jPredictions"
        case schedule = "https://api.wmata.com/Bus.svc/json/jStopSchedule"
    }
    
    /// WMATA API key from dev portal
    var apiKey: String
    
    /// The stop this object refers to
    var stopId: String
    
    /// URLSession to use for all requests
    var session: URLSession
    
    private var decoder = JSONDecoder()
    
    /// Set up Stop
    ///
    /// - parameter apiKey: WMATA API key from dev portal
    /// - parameter stopId: Stop to point this object at
    /// - parameter session: Session to call on requests on
    init(apiKey: String, stopId: String, session: URLSession = URLSession.shared) {
        self.apiKey = apiKey
        self.stopId = stopId
        self.session = session
        
    }
    
    /// Next bus arrival times at this Stop
    ///
    /// - parameter completion: Completion handler which returns `BusPredictions`
    func nextBuses(completion: @escaping (_ result: BusPredictions?, _ error: WMATAError?) -> ()) {
        var urlComponents = URLComponents(string: Stop.Urls.nextBuses.rawValue)!
        urlComponents.queryItems = [
            URLQueryItem(name: "StopID", value: self.stopId)
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(self.apiKey, forHTTPHeaderField: "api_key")
        
        self.session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                completion(nil, error?.toWMATAError())
                return
                
            }
            
            decode(data: populatedData, ofType: BusPredictions.self, completion: completion)
            
        }.resume()
        
    }
    
    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// - parameter date: Date in `YYYY-MM-DD` format for which to receive schedule for. Omit for today.
    /// - parameter completion: Completion handler which returns `StopSchedule`
    func schedule(at date: String? = nil, completion: @escaping (_ result: StopSchedule?, _ error: WMATAError?) -> ()) {
        var urlComponents = URLComponents(string: Stop.Urls.schedule.rawValue)!
        urlComponents.queryItems = [
            URLQueryItem(name: "StopID", value: self.stopId)
        ]
        
        if let populatedDate = date {
            urlComponents.queryItems?.append(URLQueryItem(name: "Date", value: populatedDate))
            
        }
        
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(self.apiKey, forHTTPHeaderField: "api_key")
        
        self.session.dataTask(with: request) { (data, response, error) in
            guard let populatedData = data else {
                completion(nil, error?.toWMATAError())
                return
                
            }
            
            decode(data: populatedData, ofType: StopSchedule.self, completion: completion)
            
        }.resume()
        
    }
    
}
