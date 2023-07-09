//
//  Globals.swift
//  MoviesApp
//
//  Created by lapshop on 6/24/23.
//

import Foundation
import UIKit
import SwiftUI

struct UserDefaultsKeys {
    static let EXPIRATION_DATE = "expiration_date"
    static let REQUEST_TOKEN = "request_token"
    static let SESSION_ID = "session_id"
}

enum LoginState {
    case requestToken
    case login
    case createSessionID
}

struct APIAuth {
    
    @AppStorage(UserDefaultsKeys.EXPIRATION_DATE) private static var expirationDateDate : String = ""
    @AppStorage(UserDefaultsKeys.REQUEST_TOKEN) private static var  request_token = ""
    @AppStorage(UserDefaultsKeys.SESSION_ID)  private static var session_ID = ""
    
    static var ApiKey : String  {
        return "a7eb5170cc529b09434c39dd39566ffe"
    }
    static var requestToken : String  {
        return request_token
    }
    
    static var sessionID : String  {
        return session_ID
    }
    
    static let accountID = 0
}

enum MediaType: String {
    case all = "all"
    case movie = "movie"
    case movies = "movies"
    case tv = "tv"
    case person = "person"
}

enum MediaCategory : Int, CaseIterable {
    case nowPlaying = 0
    case trending = 1
    case popular = 2
    case topRated = 3
}

extension MediaCategory {
    var getDescription : String {
        switch self {
        case .trending:
            return "Trending"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .nowPlaying:
            return "Now Playing"
        }
    }
}

enum TimeWindows : String {
    case day = "day"
    case week = "week"
}
