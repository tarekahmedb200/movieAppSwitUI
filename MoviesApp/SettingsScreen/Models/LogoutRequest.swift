//
//  LogoutRequest.swift
//  MoviesApp
//
//  Created by lapshop on 6/29/23.
//

import Foundation

struct LogoutRequest : Codable {
    var sessionID : String
        
    enum CodingKeys : String , CodingKey {
        case sessionID = "session_id"
    }
    
}
