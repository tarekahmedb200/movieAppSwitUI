//
//  CreateSessionRequest.swift
//  MoviesApp
//
//  Created by lapshop on 6/26/23.
//

import Foundation

struct CreateSessionRequest : Codable {
    var requestToken : String
    
    enum CodingKeys : String , CodingKey {
        case requestToken = "request_token"
    }
    
}
