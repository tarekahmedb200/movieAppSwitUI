//
//  MediaDetailsView.swift
//  MoviesApp
//
//  Created by lapshop on 6/24/23.
//

import SwiftUI
import Kingfisher

struct MediaDetailsView: View {
    
    @ObservedObject var viewModel: MediaDetailsViewModel
    @Environment(\.dismiss) var dismiss
    
    var imagePosterPath: String?
    var name : String = ""
    var description : String = ""
    
    private var headerView : some View {
        
        return HStack(alignment:.top) {
            
            if let media = viewModel.media,
               let moviePosterPath =  media.posterPath,
               let url = movieDBURL.getPosterImage(path: moviePosterPath).url {
                
                KFImage.url(url)
                    .cacheMemoryOnly()
                    .placeholder({
                        ProgressView()
                            .progressViewStyle(.circular)
                    })
                    .resizable()
                    .frame(width:150,height:150)
                    .cornerRadius(5)
            }
            
            
            VStack {
                Text(viewModel.media?.mediaTitle ?? "")
                    .bold()
                    .foregroundColor(.white)
                
                if let media = viewModel.media ,
                   let genres =  media.mediaGenres {
                    Text(genres.joined(separator:"/"))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
                
                
                HStack {
                    HStack {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width:25 ,height:25)
                            .foregroundColor(.white)
                            .scaledToFill()
                        
                        Text(viewModel.media?.mediaRunTimeFormmated ?? "")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width:25 ,height:25)
                            .foregroundColor(.white)
                            .scaledToFill()
                        
                        Text(String(format: "%.1f",viewModel.media?.rate ?? 0 ))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    
                }
                
                Button(action: {
                    viewModel.addMediaToFavourites()
                }) {
                    
                    HStack {
                        Image(systemName: viewModel.isfavourite ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.isfavourite ? .red : .white)
                        
                        Text("Like")
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                    }
                    
                }
                .padding()
                .background(.black)
                .cornerRadius(10)
            }
        }
    }
    
    
    
    private var overView : some View {
        return Section {
            
            Text(viewModel.media?.overview ?? "")
                .font(.headline)
                .foregroundColor(.white)
            
        } header: {
            Text("Overview")
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
    
    
    private var footerView : some View {
        return Section {
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing:15) {
                    ForEach(viewModel.cast,id: \.id) { cast in
                        
                        VStack {
                            if let profilePosterPath =  cast.profilePath ,
                               let url = movieDBURL.getPosterImage(path: profilePosterPath).url {
                                
                                KFImage.url(url)
                                    .cacheMemoryOnly()
                                    .loadImmediately()
                                    .forceRefresh()
                                    .placeholder({
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                            .foregroundColor(.white)
                                    })
                                    .onFailure {
                                        print("error -> \($0)")
                                    }
                                    .resizable()
                                    .frame(width:100,height:100)
                                    .clipShape(Circle())
                                    .cornerRadius(5)
                            }
                            
                            Text(cast.originalName)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .frame(height:150)
        } header: {
            Text("Cast")
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
    
    

    var body: some View {
        
        ScrollView {
            
            ZStack {
                
                if let media = viewModel.media,
                   let moviePosterPath =  media.posterPath,
                   let url = movieDBURL.getPosterImage(path: moviePosterPath).url {
                    
                    KFImage.url(url)
                        .cacheMemoryOnly()
                        .placeholder({
                            ProgressView()
                                .progressViewStyle(.circular)
                        })
                        .resizable()
                        
                }
                
                Color.black.opacity(0.3)
                
                VStack(alignment: .leading,spacing: 20) {
                    
                    Spacer()
                    
                    headerView
                    
                    overView
                    
                    footerView
                    
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
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
        }
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
