//
//  DateConfig.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 10/03/2024.
//

import Foundation

public enum DateFormat: String {
    case yyyy_MM_dd_HH_mm_ss_zzz_dash = "yyyy-MM-dd'T'HH:mm:ss'Z"
    case mmm_dd_comma_yyyy = "MMM dd, yyyy"
}

extension Date {
    public func convertDateToString(fromFormat: DateFormat = .yyyy_MM_dd_HH_mm_ss_zzz_dash, toFormat: DateFormat = .mmm_dd_comma_yyyy) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = fromFormat.rawValue
        
        if let date = dateFormatter.date(from: dateFormatter.string(from: self)) {
            dateFormatter.dateFormat = toFormat.rawValue
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            print("Error: Unable to parse the date")
            return ""
        }
    }
}

extension String {
    public func convertStringToDate(withFormat format: DateFormat = .yyyy_MM_dd_HH_mm_ss_zzz_dash) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = format.rawValue
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            print("Error: Unable to convert string to date")
            return nil
        }
    }
}


