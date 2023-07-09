//
//  MediaListItemInline.swift
//  MoviesApp
//
//  Created by lapshop on 6/30/23.
//

import SwiftUI
import Kingfisher

struct MediaListItemInline: View {
    
    var imagePosterPath: String?
    var rate: Double = 0
    var name : String = ""
    var date : String = ""
    @State var isImageLoaded : Bool = false
    
    var body: some View {
        HStack(alignment:.top,spacing: 10) {
            
            if let moviePosterPath = imagePosterPath ,
               let url = movieDBURL.getPosterImage(path: moviePosterPath).url {
                
                ZStack(alignment: .topTrailing) {
                    
                    KFImage.url(url)
                        .cacheMemoryOnly()
                        .placeholder({
                            ProgressView()
                                .progressViewStyle(.circular)
                        })
                        .onSuccess{_ in
                            isImageLoaded = true
                        }
                        .resizable()
                        .frame(width:100,height:150)
                    
                    
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
                .cornerRadius(5)
                
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                    .bold()
                
                Text(date)
                    .font(.headline)
            }
            
        }
    }
}

struct MediaListItemInline_Previews: PreviewProvider {
    static var previews: some View {
        MediaListItemInline()
            .previewLayout(.sizeThatFits)
    }
}

