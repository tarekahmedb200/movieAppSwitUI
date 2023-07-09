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
            GridListView(mediaArray: $viewModel.mediaArray)
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
