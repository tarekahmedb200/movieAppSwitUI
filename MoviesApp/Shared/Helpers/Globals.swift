//
//  Globals.swift
//  MoviesApp
//
//  Created by lapshop on 6/24/23.
//

import Foundation
import UIKit
import SwiftUI




enum NetworkError : Error {
    case badUrlRequest
    case unknown(error:Error)
}

enum LoginState {
    case requestToken
    case login
    case createSessionID
}

let cardHeight:CGFloat =  600
let cardHandleAreaHeight:CGFloat = 65

enum CardState {
    case expanded
    case collapsed
}

enum storyBoardIDS  : String {
    case homePageTabBarController = "HomePageTabBarController"
    case mediaDetailsViewController = "MediaDetailsViewController"
}

enum CellNibName : String {
    case MediaCollectionViewCell = "MediaCollectionViewCell"
    case MediaTableViewCell  = "MediaTableViewCell"
    case MediaTableViewHeader = "MediaTableViewHeader"
    case MediaSearchResultCell = "MediaSearchResultTableViewCell"
    case UserMediaPreferenceCell = "UserMediaPreferenceCell"
}

enum CellIdentifier : String {
    case MediaCollectionViewCell = "mediaCollectionViewCell"
    case MediaTableViewCell  = "mediaTableViewCell"
    case MediaTableViewHeader = "mediaTableViewHeader"
    case MediaSearchResultCell = "MediaSearchResultTableViewCell"
    case UserMediaPreferenceCell = "UserMediaPreferenceCell"
}


enum AssetNames : String {
    case movieLogo = "movieAppLogo"
    case placeHolder = "placeHolderImage"
}


struct APIAuth {
    
    @AppStorage("expiration_date") private static var expirationDateDate : String = ""
    @AppStorage("request_token") private static var  request_token = ""
    @AppStorage("session_id")  private static var session_ID = ""
    
    static var ApiKey : String  {
        return "a7eb5170cc529b09434c39dd39566ffe"
    }
    static var requestToken : String  {
        return request_token
    }
    
    static var sessionID : String  {
        return session_ID
    }
    
    static let accountID = 0
}

enum MediaType: String {
    case all = "all"
    case movie = "movie"
    case movies = "movies"
    case tv = "tv"
    case person = "person"
}

enum MediaCategory : Int , CaseIterable {
    case nowPlaying = 0
    case trending = 1
    case popular = 2
    case topRated = 3
}

extension MediaCategory {
    
    var getDescription : String {
        switch self {
        case .trending:
           return "Trending"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .nowPlaying:
            return "Now Playing"
        }
    }
}




enum TimeWindows : String {
    case day = "day"
    case week = "week"
}



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
