//
//  GridListView.swift
//  MoviesApp
//
//  Created by lapshop on 7/9/23.
//

import SwiftUI

struct GridListView: View {
    
    @Binding var mediaArray : [Media]
    
    let gridItems = [
        GridItem(.fixed(150)),
        GridItem(.fixed(150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 20) {
                ForEach(mediaArray,id:\.id) { media in
                    
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
    }
}

struct GridListView_Previews: PreviewProvider {
    static var previews: some View {
        GridListView(mediaArray: .constant([]))
    }
}
