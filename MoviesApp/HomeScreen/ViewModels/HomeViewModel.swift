//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by lapshop on 6/28/23.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    var mediaDetailsService: MediaDetailsService
    
    @Published var popularMediaArray = [Media]()
    @Published var topRatedMediaArray = [Media]()
    @Published var trendingMediaArray = [Media]()
    @Published var nowPlayingMediaArray = [Media]()
    
    @Published var searchText = ""
    @Published var searchResultMediaArray = [Media]()
    
    var subscribtions = Set<AnyCancellable>()

    init(mediaDetailsService: MediaDetailsService) {
        self.mediaDetailsService = mediaDetailsService
        
        observeSearchText()
        getMediaItems()
    }
    
    private func observeSearchText() {
        $searchText
            .filter{ text in
                return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }
            .debounce(for: .seconds(2.0), scheduler: DispatchQueue.main)
            .flatMap { text in
                self.mediaDetailsService
                    .getSearchMedia(searchWord: text)
            }
            .mapError{ error -> NetworkError in
                return NetworkError.unknown(error: error)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            },receiveValue: { [weak self] searchArray in
                self?.searchResultMediaArray = searchArray
            })
            .store(in: &subscribtions)
    }
    
    
    fileprivate func getMediaItems() {
        let popularMediaPublishers =  mediaDetailsService.getMedia(mediaCategory: .popular, mediaType: .movie)
        let topRatedMediaPublishers =  mediaDetailsService.getMedia(mediaCategory: .topRated, mediaType: .movie)
        let trendingMediaPublishers =  mediaDetailsService.getMedia(mediaCategory: .trending, mediaType: .movie)
        let nowPlayingMediaPublishers =  mediaDetailsService.getMedia(mediaCategory: .nowPlaying, mediaType: .movie)
        
        Publishers
            .CombineLatest4(popularMediaPublishers,topRatedMediaPublishers,trendingMediaPublishers,nowPlayingMediaPublishers)
            .mapError{ error -> NetworkError in
                return NetworkError.unknown(error: error)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            },receiveValue: { [weak self] popular , topRated , trending , nowPlaying in
                self?.popularMediaArray = popular
                self?.topRatedMediaArray = topRated
                self?.trendingMediaArray = trending
                self?.nowPlayingMediaArray = nowPlaying
            })
            .store(in: &subscribtions)
    }
    
}

