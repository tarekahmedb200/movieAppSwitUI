//
//  CustomError.swift
//  MoviesApp
//
//  Created by lapshop on 7/3/23.
//

import Foundation


enum NetworkError : Error {
    case badUrlRequest
    case unknown(error:Error)
}
