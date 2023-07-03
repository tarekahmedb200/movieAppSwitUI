//
//  FavouriteResponse.swift
//  MoviesApp
//
//  Created by lapshop on 7/1/23.
//

import Foundation

struct FavouriteResponse : Codable {
    var statusMessage : String
    var success : Bool?
    var statusCode : Int
    
    enum CodingKeys : String , CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}
