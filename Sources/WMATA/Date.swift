//
//  Date.swift
//
//
//  Created by Emma K Alexandra on 11/1/19.
//

import Foundation

// TODO: See if this is needed. Can't we just parse a normal date?
/// Structure describing a day, month and year in a format the WMATA API will understand
public struct WMATADate {
    /// Year of the date
    public let year: Int
    
    /// Month of the date
    public let month: Int
    
    /// Day of the date
    public let day: Int

    /// Create a WMATA Date
    ///
    /// - Parameters:
    ///     - year: Year of the date
    ///     - month: Month of the date
    ///     - day: Day of the date
    public init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
}

extension WMATADate: CustomStringConvertible {
    public var description: String {
        String(format: "%04d-%02d-%02d", year, month, day)
    }
}

extension WMATADate: URLQueryItemConvertible {
    enum URLQueryItemName: String {
        case date = "Date"
    }
    
    func queryItem(name: URLQueryItemName = .date) -> URLQueryItem {
        URLQueryItem(name: name.rawValue, value: description)
    }
}

extension Date {
    func weekdaySaturdayOrSunday() -> WeekdaySaturdayOrSunday {
        let weekday = Calendar(identifier: .gregorian).component(.weekday, from: self)
        if weekday == 1 {
            return .sunday

        } else if weekday > 1, weekday < 7 {
            return .weekday

        } else {
            return .saturday
        }
    }
}

enum WeekdaySaturdayOrSunday {
    case weekday
    case saturday
    case sunday
}
