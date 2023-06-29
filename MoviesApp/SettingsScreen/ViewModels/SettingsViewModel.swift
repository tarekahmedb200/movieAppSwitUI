//
//  SettingsViewModel.swift
//  MoviesApp
//
//  Created by lapshop on 6/29/23.
//

import Foundation
import Combine



class SettingsViewModel : ObservableObject {
    
    var authService : AuthenticationService
    
    @Published var logOutSucccess: Bool = false
    
    var subscribtions = Set<AnyCancellable>()
    
    init(authService: AuthenticationService) {
        self.authService = authService
    }
    
    @MainActor
    func handleLoginOut() {
        authService
            .logout()
            .receive(on: DispatchQueue.main)
            .mapError{ error -> NetworkError in
                return NetworkError.unknown(error: error)
            }
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            }, receiveValue: { [weak self] succcess in
                self?.logOutSucccess = succcess
            })
            .store(in: &subscribtions)
    }
    
}

