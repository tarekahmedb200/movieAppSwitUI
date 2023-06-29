//
//  RequestTokenResponse.swift
//  MoviesApp
//
//  Created by lapshop on 6/26/23.
//

import Foundation

struct RequestTokenResponse : Codable {
    var success : Bool
    var expiresAt : String
    var requestToken : String
    
    enum CodingKeys : String , CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
