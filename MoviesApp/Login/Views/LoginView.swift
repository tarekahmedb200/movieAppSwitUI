//
//  LoginView.swift
//  MoviesApp
//
//  Created by lapshop on 6/26/23.
//

import SwiftUI
import Combine

struct LoginView: View {
    
    @ObservedObject var viewModel : LoginViewModel
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                               .ignoresSafeArea()
                
                VStack {
                    
                    Image("movieLogo")
            
                    TextField("Username", text: $viewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        viewModel.handleLoginState(state: .requestToken)
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(8)
                    }
                    .padding()
                    .disabled(!viewModel.enableLoginButton)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("")
            .fullScreenCover(isPresented: $viewModel.loginSuccess) {
                HomeView(viewModel: HomeViewModel(mediaDetailsService: MediaDetailsService()))
            }
        }
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(authService: AuthenticationService()))
    }
}

