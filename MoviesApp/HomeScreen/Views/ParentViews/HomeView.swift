//
//  HomeView.swift
//  MoviesApp
//
//  Created by lapshop on 6/24/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel : HomeViewModel
    @State private var isActive: Bool = false
    
    private func sectionHeader(category : MediaCategory) -> some View {
        return HStack {
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
    
    
    var body: some View {
        
        NavigationView {
            
            Group {
                if !viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    
                    List(viewModel.searchResultMediaArray) { media in
                        
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
                                    
                                    CarouselSlider(viewModel: viewModel)
                                }
                            default :
                                HorizontalItemsView(category: category, viewModel: viewModel)
                            }
                            
                        } header: {
                            sectionHeader(category: category )
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
             .searchable(text: $viewModel.searchText)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(authService: AuthenticationService()))
    }
}

