//
//  SeeAllViewModel.swift
//  MoviesApp
//
//  Created by lapshop on 7/3/23.
//

import Foundation
import Combine

class SeeAllViewModel : ObservableObject {
    
    var mediaDetailsService : MediaDetailsService

    var category: MediaCategory
    @Published var mediaArray = [Media]()
    
    var subscribtions = Set<AnyCancellable>()
    
    init(mediaDetailsService: MediaDetailsService , category : MediaCategory) {
        self.mediaDetailsService = mediaDetailsService
        self.category = category
    }
    
    
    
   func getMedia() {
       mediaDetailsService.getMedia(mediaCategory: category, mediaType: .movie)
            .mapError{ error -> NetworkError in
                return NetworkError.unknown(error: error)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                 print(error)
                }
            },receiveValue: { [weak self] mediaArray in
                self?.mediaArray = mediaArray
            })
            .store(in: &subscribtions)
    }
    
}

