//
//  MovieListItemView.swift
//  MoviesApp
//
//  Created by lapshop on 6/24/23.
//

import SwiftUI

struct MovieListItemView: View {
    
    var imagePosterPath: String?
    var rate: Double = 0
    
    var body: some View {
        
        GeometryReader { reader in
            
            if let moviePosterPath = imagePosterPath ,
               let url = movieDBURL.getPosterImage(path: moviePosterPath).url {
                
                ZStack(alignment: .topTrailing) {
                    
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                    } placeholder: {
                        Image("image_not_found")
                    }
                    
                    
                    HStack {
                        
                        Text(String(format: "%.1f", rate))
                            .foregroundColor(.white)
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.white)
                        
                    }
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                }
                .cornerRadius(20)
                
            }
        }
    }
}

struct MovieListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListItemView()
    }
}
