//
//  FavouritesView.swift
//  MoviesApp
//
//  Created by lapshop on 6/29/23.
//

import SwiftUI

struct FavouritesView: View {
    
    @ObservedObject var viewModel: FavouritesViewModel
    
    
    
    var body: some View {
        NavigationView {
            
            GridListView(mediaArray: $viewModel.favouritesMediaArray)
            
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
