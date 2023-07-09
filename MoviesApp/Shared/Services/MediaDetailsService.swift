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
        
        return GenricServiceMethods.shared.getMethod(url: url, response: MediaResult.self)
            .map(\.media)
            .eraseToAnyPublisher()
    }
    
    func getMediaDetails(mediaID:Int,mediaType:MediaType) ->  AnyPublisher<Media,Error> {
        guard  let url = movieDBURL.requestMediaDetails(mediaId: mediaID, mediaType: mediaType).url else {
            return Fail<Media,Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        return GenricServiceMethods.shared.getMethod(url: url, response: Media.self)
    }
    
    func getSearchMedia(searchWord:String) -> AnyPublisher<[Media],Error> {
        
        
        guard let url = movieDBURL.searchMedia(searchWord: searchWord).url else {
            return Fail<[Media],Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
         
        return GenricServiceMethods.shared.getMethod(url: url, response: MediaResult.self)
        .map(\.media)
        .eraseToAnyPublisher()
    }
    
    func addMediaToFavourites(with mediaType : MediaType , mediaID:Int , favorite:Bool) -> AnyPublisher<Bool,Error>  {
        guard  let url = movieDBURL.addToFavourites.url else {
            return Fail<Bool,Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        return GenricServiceMethods.shared.methodWithBody(methodType: "POST", url: url, requestBody: FavouriteRequest(mediaType: mediaType.rawValue, mediaID: mediaID, favorite: favorite), response: FavouriteResponse.self)
            .map { response in
                return response.statusCode == 1
            }
            .eraseToAnyPublisher()
    }
    
    
    func getMediaCast(with mediaType : MediaType , mediaID:Int ) -> AnyPublisher<[Cast],Error>  {
        guard let url = movieDBURL.requestMediaCast(mediaId: mediaID, mediaType: mediaType).url else {
            return Fail<[Cast],Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        return GenricServiceMethods.shared.getMethod(url: url, response: CastResult.self)
        .map(\.cast)
        .eraseToAnyPublisher()
    }
    
}



