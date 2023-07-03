//
//  SeeAllView.swift
//  MoviesApp
//
//  Created by lapshop on 7/3/23.
//

import SwiftUI

struct SeeAllView: View {
    
    @ObservedObject var viewModel: SeeAllViewModel
    
    let gridItems = [
        GridItem(.fixed(150)),
        GridItem(.fixed(150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 20) {
                    ForEach(viewModel.mediaArray,id:\.id) { media in
                        
                        NavigationLink(destination:
                                        MediaDetailsView(viewModel: MediaDetailsViewModel(mediaDetailsService: MediaDetailsService(), personalPreferncesService: PersonalPreferncesService(), mediaType:media.type ?? "", mediaID: media.id ?? 0))
                        ) {
                            MovieListItemView(imagePosterPath: media.posterPath,rate: media.rate ?? 0)
                                .frame(width: 150 , height: 200)
                        }
                    }
                }
                .padding(20)
            }
            .onAppear {
                viewModel.getMedia()
            }
            .padding()
            .navigationTitle("See All")
        }
    }
}

struct SeeAllView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllView(viewModel: SeeAllViewModel(mediaDetailsService: MediaDetailsService(), category: .nowPlaying))
    }
}
