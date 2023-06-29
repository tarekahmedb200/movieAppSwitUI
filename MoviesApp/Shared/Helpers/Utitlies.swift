//
//  Utitlies.swift
//  MoviesApp
//
//  Created by lapshop on 6/27/23.
//

import Foundation


func getDate(from dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    //dateFormatter.timeZone = .autoupdatingCurrent
    
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    return dateFormatter.date(from: dateString)
}

extension Date {
    
    var isAfterToday : Bool {
        return self > Date.now
    }
    
}
