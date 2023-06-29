//
//  FavouritesViewModel.swift
//  MoviesApp
//
//  Created by lapshop on 6/29/23.
//

import Foundation
import Combine

class FavouritesViewModel: ObservableObject {
    
    var personalPreferncesService : PersonalPreferncesService
    
    @Published var favouritesMediaArray = [Media]()

    var subscribtions = Set<AnyCancellable>()

    init(personalPreferncesService : PersonalPreferncesService) {
        self.personalPreferncesService = personalPreferncesService
        self.getFavouriteMedia()
    }
    
    func getFavouriteMedia() {
        self.personalPreferncesService
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
                self?.favouritesMediaArray = favourites
            })
            .store(in: &subscribtions)
    }
    
    
}
