//
//  Date+Ext.swift
//  MoviesApp
//
//  Created by lapshop on 7/3/23.
//

import Foundation

extension Date {
    var isAfterToday : Bool {
        return self > Date.now
    }
    
    static func getDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.date(from: dateString)
    }
    
    static  func minutesToHoursMinutes (minutes : Int) -> (hours:Int, minutes:Int) {
      return (minutes / 60, minutes % 60)
    }
    
}


