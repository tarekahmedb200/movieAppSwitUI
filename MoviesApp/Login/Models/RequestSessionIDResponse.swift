//
//  RequestSessionIDResponse.swift
//  MoviesApp
//
//  Created by lapshop on 6/26/23.
//

import Foundation

struct RequestSessionIDResponse : Codable {
    var success : Bool
    var sessionID : String?
    
    enum CodingKeys : String , CodingKey {
        case success
        case sessionID = "session_id"
    }
}
