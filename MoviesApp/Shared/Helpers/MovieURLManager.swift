//
//  MovieURLManager.swift
//  MoviesApp
//
//  Created by lapshop on 7/3/23.
//

import Foundation


enum movieDBURL   {
    static let baseUrl = "https://api.themoviedb.org/3"
    static let apiKeyParameter = "?api_key="
    static let sessonKeyParameter = "&session_id="
    static let querySeachParameter = "&query="
    
    case requestToken
    case login
    case requestSession
    case requestGuestSession
    
    case requestTrendingMovies(mediaType: MediaType)
    case requestPopularMovies(mediaType: MediaType)
    case requestTopRatedMovies(mediaType: MediaType)
    case requestNowPlayingMovies(mediaType: MediaType)
    case requestMediaDetails(mediaId:Int,mediaType: MediaType)
    case requestMediaCast(mediaId:Int,mediaType: MediaType)
    
    case addToFavourites
    case addToWatchList
    
    case getFavouriteMedia(mediaType:MediaType)
    case getWatchListMedia(mediaType:MediaType)
    
    case getPosterImage(path:String)
    
    case searchMedia(searchWord:String)
    
    case deleteSession
    
    var url : URL? {
        guard let url = URL(string: self.stringUrl) else {
            return nil
        }
        return url
    }
    
    var stringUrl : String {
        switch self {
        case .requestToken:
            return movieDBURL.baseUrl + "/authentication/token/new" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
        
        case .login:
            return movieDBURL.baseUrl + "/authentication/token/validate_with_login" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
         
        case .requestSession:
            return movieDBURL.baseUrl + "/authentication/session/new" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
            
        case .requestGuestSession:
            return movieDBURL.baseUrl + "/authentication/guest_session/new" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
        
        case .requestTrendingMovies(let mediaType):
            return movieDBURL.baseUrl + "/trending/" + mediaType.rawValue + "/" + TimeWindows.week.rawValue + movieDBURL.apiKeyParameter + APIAuth.ApiKey
        case .requestPopularMovies(let mediaType):
            return movieDBURL.baseUrl + "/\(mediaType.rawValue)/popular" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
         
        case .requestTopRatedMovies(let mediaType):
            return movieDBURL.baseUrl + "/\(mediaType.rawValue)/top_rated" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
        
        case .requestNowPlayingMovies(let mediaType):
            return movieDBURL.baseUrl + "/\(mediaType.rawValue)/now_playing" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
            
        case .getPosterImage(let path):
            return "https://image.tmdb.org/t/p/w500/"+path
            
            
        case .requestMediaDetails(let mediaId,let mediaType):
            return movieDBURL.baseUrl + "/\(mediaType)/\(mediaId)" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
            
        case .addToWatchList:
            return movieDBURL.baseUrl + "/account/"+"\(APIAuth.accountID)" + "/watchlist" + movieDBURL.apiKeyParameter + APIAuth.ApiKey + movieDBURL.sessonKeyParameter + APIAuth.sessionID
         
        case .addToFavourites:
            return movieDBURL.baseUrl + "/account/"+"\(APIAuth.accountID)" + "/favorite" + movieDBURL.apiKeyParameter + APIAuth.ApiKey + movieDBURL.sessonKeyParameter + APIAuth.sessionID


        case .getFavouriteMedia(let mediaType):
            return movieDBURL.baseUrl + "/account/"+"\(APIAuth.accountID)" + "/favorite/\(mediaType.rawValue)" + movieDBURL.apiKeyParameter + APIAuth.ApiKey + movieDBURL.sessonKeyParameter + APIAuth.sessionID
            
        case .getWatchListMedia(let mediaType):
            return movieDBURL.baseUrl + "/account/"+"\(APIAuth.accountID)" + "/watchlist/\(mediaType.rawValue)" + movieDBURL.apiKeyParameter + APIAuth.ApiKey + movieDBURL.sessonKeyParameter + APIAuth.sessionID
            
        case .searchMedia(let searchWord):
            return movieDBURL.baseUrl + "/search/multi"+movieDBURL.apiKeyParameter + APIAuth.ApiKey + movieDBURL.querySeachParameter + searchWord
            
            
        case .deleteSession:
            return movieDBURL.baseUrl + "/authentication/session" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
            
        case .requestMediaCast(let mediaId , let mediaType):
            return movieDBURL.baseUrl + "/\(mediaType.rawValue)/\(mediaId)/credits" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
        }
    }
    
    
}
