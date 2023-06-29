//
//  FavouritesView.swift
//  MoviesApp
//
//  Created by lapshop on 6/29/23.
//

import SwiftUI

struct FavouritesView: View {
    
    @ObservedObject var viewModel: FavouritesViewModel
    
    let gridItems = [
        GridItem(.fixed(150)),
        GridItem(.fixed(150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 20) {
                    ForEach(viewModel.favouritesMediaArray,id:\.id) { media in
                        NavigationLink(destination: MediaDetailsView()) {
                            MovieListItemView(imagePosterPath: media.posterPath,rate: media.rate)
                                .frame(width: 150 , height: 200)
                        }
                    }
                }
                .padding(20)
            }
            .onAppear {
                viewModel.getFavouriteMedia()
            }
            .padding()
            .navigationTitle("Favourites")
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView(viewModel: FavouritesViewModel(personalPreferncesService: PersonalPreferncesService()))
    }
}
