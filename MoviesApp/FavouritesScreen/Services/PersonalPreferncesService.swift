//
//  PersonalPreferncesService.swift
//  MoviesApp
//
//  Created by lapshop on 6/29/23.
//

import Foundation
import Combine


class PersonalPreferncesService  {
    
    func getFavouritesMedia(mediaType:MediaType) -> AnyPublisher<[Media],Error> {
        
        guard  let url = movieDBURL.getFavouriteMedia(mediaType: mediaType).url else {
            return Fail<[Media],Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        return GenricServiceMethods.shared.getMethod(url: url, response: MediaResult.self)
            .map(\.media)
            .eraseToAnyPublisher()
    }
    
}
