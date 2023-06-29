//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by lapshop on 6/24/23.
//

import Foundation
import Combine


class LoginViewModel : ObservableObject {
    
    var authService : AuthenticationService
    
    @Published  var username: String = ""
    @Published  var password: String = ""
    @Published var loginSuccess: Bool = false
    @Published var enableLoginButton : Bool = false

    var subscribtions = Set<AnyCancellable>()
    
    init(authService: AuthenticationService) {
        self.authService = authService
        observeTextFields()
    }
    
    
    private func observeTextFields() {
        $username
            .combineLatest($password)
            .map { username , password in
                return !(username.isEmpty && password.isEmpty)
            }
            .assign(to: &$enableLoginButton)
    }

    
    @MainActor
    func handleLoginState(state:LoginState) {
        
        switch state {
                
        case .requestToken:
          authService
                .requestToken()
                .mapError{ error -> NetworkError in
                    return NetworkError.unknown(error: error)
                }
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                     print(error)
                    }
                }, receiveValue: { [weak self]  success in
                    if success {
                        self?.handleLoginState(state: .login)
                    }
                })
                .store(in: &subscribtions)
            
        case .login:
            authService
                // blackadam200 , thehulk200
                .login(with: username, and: password)
                .mapError{ error -> NetworkError in
                    return NetworkError.unknown(error: error)
                }
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                     print(error)
                    }
                }, receiveValue: { [weak self]  success in
                    if success == true {
                        self?.handleLoginState(state: .createSessionID)
                    }
                })
                .store(in: &subscribtions)
                
        case .createSessionID:
            authService
                .createSessionID()
                .receive(on: DispatchQueue.main)
                .mapError{ error -> NetworkError in
                    return NetworkError.unknown(error: error)
                }
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                     print(error)
                    }
                }, receiveValue: { [weak self] succcess in
                    self?.loginSuccess = succcess
                })
                .store(in: &subscribtions)
        }
    }
    
}
 
