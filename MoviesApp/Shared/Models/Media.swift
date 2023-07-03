//
//  Media.swift
//  MoviesApp
//
//  Created by lapshop on 6/28/23.
//

import Foundation

struct Media : Codable {
    
    var id : Int?
    var posterPath : String?
    var adult: Bool?
    var overview : String?
    var releaseDate : String?
    var firstAirDate : String?
    var title : String?
    var name : String?
    var backdropPath : String?
    var popularity : Double?
    var runTime : Int?
    var genres : [Genre]?
    var type : String?
    var rate : Double?
    
    var mediaTitle : String {
        return title ?? name ?? ""
    }
    
    var mediaDate : String {
        return releaseDate ?? firstAirDate ?? ""
    }
    
    var mediaGenres: [String] {
        var genresNames =  [String]()
        guard let genres = genres else {
            return []
        }
        genresNames = genres.map({
            return $0.name
        })
        
        return genresNames
    }
    
    enum CodingKeys : String , CodingKey {
        case id
        case genres
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case title
        case name
        case backdropPath = "backdrop_path"
        case popularity
        case runTime = "runtime"
        case type = "media_type"
        case rate = "vote_average"
    }
    
}
