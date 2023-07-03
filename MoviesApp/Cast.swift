//
//  Cast.swift
//  MoviesApp
//
//  Created by lapshop on 7/1/23.
//

import Foundation


struct CastResult : Codable {
    let id: Int
    let cast: [Cast]
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast = "cast"
    }
}

struct Cast: Codable {
    let id: Int?
    let name: String
    let character: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let castId: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, character
        case originalName = "original_name"
        case popularity, profilePath = "profile_path"
        case castId = "cast_id"
    }
    
}






