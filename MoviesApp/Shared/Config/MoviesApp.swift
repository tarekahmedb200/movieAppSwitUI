//
//  MoviesApp.swift
//  MoviesApp
//
//  Created by lapshop on 6/24/23.
//

import SwiftUI

@main
struct MoviesApp: App {
    
    @AppStorage("expiration_date") var expirationDateDate : String = ""
    @AppStorage("request_token") var  request_token = ""
    @State var showLoginScreen : Bool = false
    
    var body: some Scene {
        WindowGroup {
            
            
            if let date = getDate(from: expirationDateDate) ,
               date.isAfterToday ,
               !request_token.isEmpty {
                
                TabView {
                    HomeView(viewModel: HomeViewModel(mediaDetailsService: MediaDetailsService()))
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    
                    FavouritesView(viewModel: FavouritesViewModel(personalPreferncesService: PersonalPreferncesService()))
                        .tabItem {
                            Image(systemName: "star.fill")
                            Text("Favourites")
                        }
                    
                    SettingsView(viewModel: SettingsViewModel(authService: AuthenticationService()))
                        .tabItem {
                            Image(systemName: "ellipsis.curlybraces")
                            Text("Setting")
                        }
                }
            } else {
                LoginView(viewModel: LoginViewModel(authService: AuthenticationService()))
            }
            
            
            
        }
    }
}



