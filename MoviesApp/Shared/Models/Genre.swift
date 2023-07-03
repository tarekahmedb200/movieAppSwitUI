//
//  Genre.swift
//  MoviesApp
//
//  Created by lapshop on 6/28/23.
//

import Foundation

struct Genre : Codable {
    
    var id  : Int
    var name : String
    
    enum CodingKeys : String , CodingKey {
      case id
      case name
    }
    
}
