//
//  MoviesApp.swift
//  MoviesApp
//
//  Created by lapshop on 6/24/23.
//

import SwiftUI

@main
struct MoviesApp: App {
    
    @AppStorage(UserDefaultsKeys.EXPIRATION_DATE) var expirationDateDate : String = ""
    @AppStorage(UserDefaultsKeys.REQUEST_TOKEN) var  request_token = ""
    @State var showLoginScreen : Bool = false
    
    var body: some Scene {
        WindowGroup {
            
            
            if let date = Date.getDate(from: expirationDateDate) ,
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
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                    
                }
            } else {
                LoginView(viewModel: LoginViewModel(authService: AuthenticationService()))
            }
            
            
            
        }
    }
}

class Settings: ObservableObject {
    @Published var isPresentView = false
}



