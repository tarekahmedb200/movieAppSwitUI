//
//  MediaDetailsViewModel.swift
//  MoviesApp
//
//  Created by lapshop on 6/30/23.
//

import Foundation
import Combine


class MediaDetailsViewModel: ObservableObject {
    
    var mediaDetailsService : MediaDetailsService
    var personalPreferncesService : PersonalPreferncesService
    
    var mediaType: String = ""
    var mediaID: Int = 0
    
    @Published var cast:  [Cast] = []
    @Published var media: Media?
    @Published var isfavourite: Bool = false
    
    var subscribtions = Set<AnyCancellable>()
    
    init(mediaDetailsService : MediaDetailsService,personalPreferncesService:PersonalPreferncesService,mediaType:String,mediaID: Int) {
        self.mediaDetailsService = mediaDetailsService
        self.personalPreferncesService = personalPreferncesService
        self.mediaType = mediaType
        self.mediaID = mediaID
    }
    
    func getMediaDetails() {
        
        mediaDetailsService
            .getMediaDetails(mediaID: mediaID, mediaType: MediaType(rawValue: mediaType) ?? .movie)
            .mapError{ error -> NetworkError in
                return NetworkError.unknown(error: error)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                 print(error)
                }
            },receiveValue: { [weak self] media  in
                self?.media = media
            })
            .store(in: &subscribtions)
        
        
       personalPreferncesService
            .getFavouritesMedia(mediaType: .movies)
            .mapError{ error -> NetworkError in
                return NetworkError.unknown(error: error)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                 print(error)
                }
            },receiveValue: { [weak self] favourites  in
                self?.isfavourite = favourites.contains { [weak self] media in
                    self?.mediaID == media.id
                }
            })
            .store(in: &subscribtions)
        
         mediaDetailsService.getMediaCast(with: MediaType(rawValue: mediaType) ?? .movie, mediaID: mediaID)
            .mapError{ error -> NetworkError in
                return NetworkError.unknown(error: error)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                 print(error)
                }
            },receiveValue: { [weak self] cast  in
                self?.cast = cast
            })
            .store(in: &subscribtions)
    }
    
    
    func addMediaToFavourites() {
        
        isfavourite.toggle()
        
        mediaDetailsService
            .addMediaToFavourites(with: MediaType(rawValue: media?.type ?? "movie") ?? .movie, mediaID:mediaID , favorite: isfavourite)
            .mapError{ error -> NetworkError in
                return NetworkError.unknown(error: error)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            },receiveValue: { [weak self] isfavourite  in
                self?.isfavourite = isfavourite
            })
            .store(in: &subscribtions)
    }
    
}


