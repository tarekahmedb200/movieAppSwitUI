//
//  MovieListItemView.swift
//  MoviesApp
//
//  Created by lapshop on 6/24/23.
//

import SwiftUI
import Kingfisher

struct MovieListItemView: View {
    
    var imagePosterPath: String?
    var rate: Double = 0
    @State var isImageLoaded : Bool = false
    
    var body: some View {
        
        if let moviePosterPath = imagePosterPath ,
           let url = movieDBURL.getPosterImage(path: moviePosterPath).url {
            
            ZStack(alignment: .topTrailing) {
                
                KFImage.url(url)
                    .placeholder({
                        ProgressView()
                            .progressViewStyle(.circular)
                    })
                    .onSuccess{_ in
                        isImageLoaded = true
                    }
                    .resizable()
                
                HStack {
                    
                    Text(String(format: "%.1f", rate))
                        .foregroundColor(.white)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.white)
                    
                }
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .background(Color.blue)
                .cornerRadius(10)
                .opacity(isImageLoaded ? 1 : 0)
            }
            .cornerRadius(20)
            
        }
    }
}

struct MovieListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListItemView()
    }
}
