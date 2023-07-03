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
            .map{
                print(try? JSONSerialization.jsonObject(with: $0.data, options: []) as? [String: Any])
                return $0.data
            }
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
            .map{
                print(try? JSONSerialization.jsonObject(with: $0.data, options: []) as? [String: Any])
                return $0.data
            }
            .decode(type: Media.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getSearchMedia(searchWord:String) -> AnyPublisher<[Media],Error> {
        
        
        guard let url = movieDBURL.searchMedia(searchWord: searchWord).url else {
            return Fail<[Media],Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
         
        return URLSession.shared.dataTaskPublisher(for: url)
            .map {
                print(try? JSONSerialization.jsonObject(with: $0.data, options: []) as? [String: Any])
                return $0.data
            }
            .decode(type: MediaResult.self, decoder: JSONDecoder())
            .map {
                print($0)
                return $0.media
            }
            .eraseToAnyPublisher()
    }
    
    func addMediaToFavourites(with mediaType : MediaType , mediaID:Int , favorite:Bool) -> AnyPublisher<Bool,Error>  {
        guard  let url = movieDBURL.addToFavourites.url else {
            return Fail<Bool,Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let encoder = JSONEncoder()
            let body = FavouriteRequest(mediaType: mediaType.rawValue, mediaID: mediaID, favorite: favorite)
            request.httpBody = try encoder.encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .map{
                    print(try? JSONSerialization.jsonObject(with: $0.data, options: []) as? [String: Any])
                    return $0.data
                }
                .decode(type: FavouriteResponse.self, decoder: JSONDecoder())
                .map { response in
                    return response.statusCode == 1
                }
                .eraseToAnyPublisher()
    
        }catch {
            return Fail<Bool,Error>(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    
    func getMediaCast(with mediaType : MediaType , mediaID:Int ) -> AnyPublisher<[Cast],Error>  {
        guard let url = movieDBURL.requestMediaCast(mediaId: mediaID, mediaType: mediaType).url else {
            return Fail<[Cast],Error>(error: NSError(domain: "error", code: 12))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{
                print(try? JSONSerialization.jsonObject(with: $0.data, options: []) as? [String: Any])
                return $0.data
            }
            .decode(type: CastResult.self, decoder: JSONDecoder())
            .map(\.cast)
            .eraseToAnyPublisher()
    }
    
}



