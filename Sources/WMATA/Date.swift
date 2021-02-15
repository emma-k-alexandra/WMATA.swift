//
//  Date.swift
//
//
//  Created by Emma K Alexandra on 11/1/19.
//

import Foundation

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

let FORMAT = "yyyy-MM-dd'T'HH:mm:ss"

extension String {
    func toWMATADate() throws -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = FORMAT
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "EST")!
        guard let date = formatter.date(from: self) else {
            throw WMATAError(statusCode: 0, message: "Date provided not valid")
        }

        return date
    }
}

extension Date {
    func toWMATAString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = FORMAT
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "EST")!

        return formatter.string(from: self)
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
