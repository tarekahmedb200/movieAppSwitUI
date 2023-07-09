//
//  CarouselSlider.swift
//  MoviesApp
//
//  Created by lapshop on 7/3/23.
//

import SwiftUI

struct CarouselSlider: View {
    
    
    @ObservedObject var viewModel: HomeViewModel
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var selectedNum: Int = 0
    @State private var index: Int = 0
    
    
    var body: some View {
        TabView(selection:$selectedNum ) {
            
            ForEach(0..<self.viewModel.nowPlayingMediaArray.count) { i in
                
                let media = self.viewModel.nowPlayingMediaArray[i]
                
                NavigationLink(destination:
                                MediaDetailsView(viewModel: MediaDetailsViewModel(mediaDetailsService: MediaDetailsService(),personalPreferncesService: PersonalPreferncesService(), mediaType:media.type ?? "", mediaID: media.id ?? 0))
                               
                ) {
                    MovieListItemView(imagePosterPath: media.posterPath,rate: media.rate ?? 0)
                        .frame(width: 300 , height: 500)
                }
                .buttonStyle(PlainButtonStyle())
                .tag(i)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(height:600)
        .onReceive(timer, perform: { _ in
            withAnimation {
                index += 1
                selectedNum = index % viewModel.nowPlayingMediaArray.count
                index = selectedNum
            }
        })
    }
}

struct CarouselSlider_Previews: PreviewProvider {
    static var previews: some View {
        CarouselSlider(viewModel: HomeViewModel(mediaDetailsService: MediaDetailsService()))
    }
}
