//
//  FavouriteRequest.swift
//  MoviesApp
//
//  Created by lapshop on 7/1/23.
//

import Foundation

struct FavouriteRequest : Codable {
    var mediaType : String
    var mediaID : Int
    var favorite : Bool
    
    enum CodingKeys : String , CodingKey {
        case mediaType = "media_type"
        case mediaID = "media_id"
        case favorite
    }
    
}
