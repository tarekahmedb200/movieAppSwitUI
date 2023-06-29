//
//  HomeView.swift
//  MoviesApp
//
//  Created by lapshop on 6/24/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel : HomeViewModel
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var selectedNum: Int = 0
    @State private var index: Int = 0
    
    var body: some View {
        
        NavigationView {
            
        List(MediaCategory.allCases , id: \.self) { category in
            
            Section {
                
                switch category {
                    
                case .nowPlaying :
                    
                    if viewModel.nowPlayingMediaArray.count > 0 {
                        TabView(selection:$selectedNum ) {
                            ForEach(0..<viewModel.nowPlayingMediaArray.count) { i in
                                
                                let movie = viewModel.nowPlayingMediaArray[i]
                                
                                
                                NavigationLink(destination: MediaDetailsView()) {
                                    MovieListItemView(imagePosterPath: movie.posterPath,rate: movie.rate)
                                        .frame(width: 150 , height: 250)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .tag(i)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        .frame(height:300)
                        .onReceive(timer, perform: { _ in
                               withAnimation {
                                   index += 1
                                   selectedNum = index % viewModel.nowPlayingMediaArray.count
                                   print(selectedNum)
                                   index = selectedNum
                               }
                         })
                    }
                    
                    
                    
                    
                default :
                    CustomViewOne(category: category, viewModel: viewModel)
                }
               
                
                
                
                
            } header: {
                Text(category.getDescription)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.black)
            }
        }
    }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(authService: AuthenticationService()))
    }
}


struct CustomViewOne : View {
    
    var category : MediaCategory
    @ObservedObject var viewModel : HomeViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 15) {
                switch category {
                    
                case .trending:
                    ForEach(viewModel.trendingMediaArray, id: \.id) { movie in
                        
                        NavigationLink(destination: MediaDetailsView()) {
                            MovieListItemView(imagePosterPath: movie.posterPath,rate: movie.rate)
                                .frame(width: 150 , height: 250)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                case .popular:
                    ForEach(viewModel.popularMediaArray, id: \.id) { movie in
                        NavigationLink(destination: MediaDetailsView()) {
                            MovieListItemView(imagePosterPath: movie.posterPath,rate: movie.rate)
                                .frame(width: 150 , height: 250)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                case .topRated:
                    ForEach(viewModel.topRatedMediaArray, id: \.id) { movie in
                        NavigationLink(destination: MediaDetailsView()) {
                            MovieListItemView(imagePosterPath: movie.posterPath,rate: movie.rate)
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
