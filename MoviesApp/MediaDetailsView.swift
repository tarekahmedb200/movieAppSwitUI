//
//  MediaDetailsView.swift
//  MoviesApp
//
//  Created by lapshop on 6/24/23.
//

import SwiftUI

struct MediaDetailsView: View {
    
    @ObservedObject var viewModel: MediaDetailsViewModel
    @Environment(\.dismiss) var dismiss
    
    var imagePosterPath: String?
    var name : String = ""
    var description : String = ""
    
    var body: some View {
        
        GeometryReader { reader in
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    
                    ZStack {
                        
                        if let media = viewModel.media,
                           let moviePosterPath =  media.posterPath,
                           let url = movieDBURL.getPosterImage(path: moviePosterPath).url {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .frame(height:400)
                                    .cornerRadius(2)
                            } placeholder: {
                                Image("image_not_found")
                            }
                        }
                        
                        Color.black.opacity(0.1)
                    }
                    
                    
                    if let media = viewModel.media ,
                       let genres =  media.mediaGenres {
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack {
                                ForEach(genres,id: \.self) { cat in
                                    Text(cat)
                                        .background(.black)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                }
                            }
                        }
                        .frame(height: 50)
                    }
                    
                    
                    VStack(alignment: .leading) {
                        
                        Text(viewModel.media?.mediaTitle ?? "")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                        
                        Text(viewModel.media?.overview ?? "")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.cast,id: \.id) { cast in
                                
                                VStack {
                                    if let profilePosterPath =  cast.profilePath ,
                                       let url = movieDBURL.getPosterImage(path: profilePosterPath).url {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .frame(width:50,height:100)
                                                .cornerRadius(5)
                                        } placeholder: {
                                            Image("image_not_found")
                                        }
                                    }
                
                                    Text(cast.name)
                                        .font(.footnote)
                                        .bold()
                                        .foregroundColor(.black)
                                        
                                    Text(cast.originalName)
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                }
                                
                                
                                
                            }
                        }
                    }
                    .frame(height: 400)
            
                }
                
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.addMediaToFavourites()
                }) {
                    Image(systemName: viewModel.isfavourite ? "heart.fill" : "heart")
                }
            }
        }
       
        .ignoresSafeArea()
        .onAppear {
            viewModel.getMediaDetails()
        }
    }
}

struct MediaDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetailsView(viewModel: MediaDetailsViewModel(mediaDetailsService: MediaDetailsService(), personalPreferncesService: PersonalPreferncesService(), mediaType: "movie", mediaID: 0))
    }
}
