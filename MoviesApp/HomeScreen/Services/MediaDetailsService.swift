//
//  MediaDetailsService.swift
//  MoviesApp
//
//  Created by lapshop on 6/28/23.
//

import Foundation
import Combine



class MediaDetailsService  {
    
    func getMedia(mediaCategory:MediaCategory,mediaType:MediaType) -> AnyPublisher<[Media],Error> {
        
        var choosenUrl : URL?
        switch mediaCategory {
        case .topRated:
            choosenUrl = movieDBURL.requestTopRatedMovies(mediaType: mediaType).url
        case .popular:
            choosenUrl = movieDBURL.requestPopularMovies(mediaType: mediaType).url
        case .trending:
            choosenUrl = movieDBURL.requestTrendingMovies(mediaType: mediaType).url
        case .nowPlaying:
            choosenUrl = movieDBURL.requestNowPlayingMovies(mediaType: mediaType).url
        }
        
        guard let url = choosenUrl else {
            return Fail<[Media],Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MediaResult.self, decoder: JSONDecoder())
            .map(\.media)
            .eraseToAnyPublisher()
    }
    
    func getMediaDetails(mediaID:Int,mediaType:MediaType) ->  AnyPublisher<Media,Error> {
        
        guard  let url = movieDBURL.requestMediaDetails(mediaId: mediaID, mediaType: mediaType).url else {
            return Fail<Media,Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Media.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}



