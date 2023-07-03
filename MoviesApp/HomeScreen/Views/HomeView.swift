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
    @State private var isActive: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            Group {
                if !viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    
                    List(viewModel.searchResultMediaArray,id:\.id) { media in
                        
                        NavigationLink(destination:
                                        MediaDetailsView(viewModel: MediaDetailsViewModel(mediaDetailsService: MediaDetailsService(),personalPreferncesService: PersonalPreferncesService(), mediaType:media.type ?? "", mediaID: media.id ?? 0))
                                       
                        ) {
                            MediaListItemInline(imagePosterPath: media.posterPath, rate: media.rate ?? 0, name: media.mediaTitle,date:media.releaseDate ?? "")
                                .frame(height: 200)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                }else {
                    List(MediaCategory.allCases , id: \.self) { category in
                        
                        Section {
                            
                            switch category {
                                
                            case .nowPlaying :
                                
                                if viewModel.nowPlayingMediaArray.count > 0 {
                                    TabView(selection:$selectedNum ) {
                                        ForEach(0..<viewModel.nowPlayingMediaArray.count) { i in
                                            
                                            let media = viewModel.nowPlayingMediaArray[i]
                                            
                                            
                                            NavigationLink(destination:
                                                            MediaDetailsView(viewModel: MediaDetailsViewModel(mediaDetailsService: MediaDetailsService(),personalPreferncesService: PersonalPreferncesService(), mediaType:media.type ?? "", mediaID: media.id ?? 0))
                                                           
                                            ) {
                                                MovieListItemView(imagePosterPath: media.posterPath,rate: media.rate ?? 0)
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
                            
                            HStack {
                                Text(category.getDescription)
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundColor(.black)
                                
                                if category != .nowPlaying {
                                    Spacer()
                                    
                                    NavigationLink(destination:
                                                    SeeAllView(viewModel: SeeAllViewModel(mediaDetailsService: MediaDetailsService(), category: category)),isActive: $isActive
                                                   
                                    ) {
                                        Button("See All") {
                                            isActive = true
                                        }
                                    }
                                }
                                
                                
                                
                            }
                            
                            
                        }
                    }
                }
            }.listStyle(GroupedListStyle())
                .searchable(text: $viewModel.searchText)
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
                    ForEach(viewModel.trendingMediaArray, id: \.id) { media in
                        
                        NavigationLink(destination:
                                        MediaDetailsView(viewModel: MediaDetailsViewModel(mediaDetailsService: MediaDetailsService(),personalPreferncesService: PersonalPreferncesService(), mediaType:media.type ?? "", mediaID: media.id ?? 0))
                        ) {
                            MovieListItemView(imagePosterPath: media.posterPath,rate: media.rate ?? 0)
                                .frame(width: 150 , height: 250)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                case .popular:
                    ForEach(viewModel.popularMediaArray, id: \.id) { media in
                        NavigationLink(destination:
                                        MediaDetailsView(viewModel: MediaDetailsViewModel(mediaDetailsService: MediaDetailsService(),personalPreferncesService: PersonalPreferncesService(), mediaType:media.type ?? "", mediaID: media.id ?? 0))
                        ) {
                            MovieListItemView(imagePosterPath: media.posterPath,rate: media.rate ?? 0)
                                .frame(width: 150 , height: 250)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                case .topRated:
                    ForEach(viewModel.topRatedMediaArray, id: \.id) { media in
                        NavigationLink(destination:
                                        MediaDetailsView(viewModel: MediaDetailsViewModel(mediaDetailsService: MediaDetailsService(),personalPreferncesService: PersonalPreferncesService(), mediaType:media.type ?? "", mediaID: media.id ?? 0))
                        ) {
                            MovieListItemView(imagePosterPath: media.posterPath,rate: media.rate ?? 0)
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
