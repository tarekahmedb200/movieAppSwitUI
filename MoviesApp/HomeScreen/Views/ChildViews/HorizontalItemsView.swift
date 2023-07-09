//
//  HorizontalItemsView.swift
//  MoviesApp
//
//  Created by lapshop on 7/3/23.
//

import SwiftUI

struct HorizontalItemsView: View {
    var category: MediaCategory
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 15) {
                switch category {
                    
                case .trending:
                    ForEach(viewModel.trendingMediaArray) { media in
                        
                        NavigationLink(destination:
                                        MediaDetailsView(viewModel: MediaDetailsViewModel(mediaDetailsService: MediaDetailsService(),personalPreferncesService: PersonalPreferncesService(), mediaType:media.type ?? "", mediaID: media.id ?? 0))
                        ) {
                            MovieListItemView(imagePosterPath: media.posterPath,rate: media.rate ?? 0)
                                .frame(width: 150 , height: 250)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                case .popular:
                    ForEach(viewModel.popularMediaArray) { media in
                        NavigationLink(destination:
                                        MediaDetailsView(viewModel: MediaDetailsViewModel(mediaDetailsService: MediaDetailsService(),personalPreferncesService: PersonalPreferncesService(), mediaType:media.type ?? "", mediaID: media.id ?? 0))
                        ) {
                            MovieListItemView(imagePosterPath: media.posterPath,rate: media.rate ?? 0)
                                .frame(width: 150 , height: 250)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                case .topRated:
                    ForEach(viewModel.topRatedMediaArray) { media in
                        NavigationLink(destination:
                                        MediaDetailsView(viewModel: MediaDetailsViewModel(mediaDetailsService: MediaDetailsService(),personalPreferncesService: PersonalPreferncesService(), mediaType:media.type ?? "", mediaID: media.id ?? 0))
                        ) {
                            MovieListItemView(imagePosterPath: media.posterPath,rate: media.rate ?? 0)
                                .frame(width: 150 , height: 250)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                default :
                    EmptyView()
                }
            }
        }
        
    }
}

struct HorizontalItemsView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalItemsView(category: .nowPlaying, viewModel: HomeViewModel(mediaDetailsService: MediaDetailsService()))
    }
}
