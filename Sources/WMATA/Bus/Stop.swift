//
//  Stop.swift
//  
//
//  Created by Emma Foster on 6/17/19.
//

import Foundation

/// Information relating to a specific MetroBus stop
public class Stop: Fetcher, RequestBuilder {
    /// URLs of WMATA endpoints relating to Stops
    enum Urls: String {
        case nextBuses = "https://api.wmata.com/NextBusService.svc/json/jPredictions"
        case schedule = "https://api.wmata.com/Bus.svc/json/jStopSchedule"
    }
    
    /// WMATA API key from dev portal
    public var key: String
    
    /// The stop this object refers to
    public var stopId: String
    
    /// URLSession to use for all requests
    public var urlSession: URLSession
    
    private var decoder = JSONDecoder()
    
    /// Set up Stop
    ///
    /// - parameter apiKey: WMATA API key from dev portal
    /// - parameter stopId: Stop to point this object at
    /// - parameter session: Session to call on requests on
    public init(apiKey: String, stopId: String, session: URLSession = URLSession.shared) {
        self.key = apiKey
        self.stopId = stopId
        self.urlSession = session
        
    }
    
    /// Next bus arrival times at this Stop
    ///
    /// - parameter completion: Completion handler which returns `BusPredictions`
    public func nextBuses(completion: @escaping (Result<BusPredictions, WMATAError>) -> ()) {
        self.fetch(with: self.buildRequest(fromUrl: Stop.Urls.nextBuses.rawValue, andQueryItems: [("StopID", self.stopId)]), completion: completion)
        
    }
    
    /// Set of buses scheduled to arrive at this Stop at a given date.
    ///
    /// - parameter date: Date in `YYYY-MM-DD` format for which to receive schedule for. Omit for today.
    /// - parameter completion: Completion handler which returns `StopSchedule`
    public func schedule(at date: String? = nil, completion: @escaping (Result<StopSchedule, WMATAError>) -> ()) {
        var queryItems = [("StopID", self.stopId)]
        
        if let date = date {
            queryItems.append(("Date", date))
            
        }
        
        self.fetch(with: self.buildRequest(fromUrl: Stop.Urls.schedule.rawValue, andQueryItems: queryItems), completion: completion)
        
    }
    
}

extension Stop: ApiKey {
    func apiKey() -> String {
        self.key
    }
    
    
}

extension Stop: Session {
    func session() -> URLSession {
        self.urlSession
    }
    
    
}
