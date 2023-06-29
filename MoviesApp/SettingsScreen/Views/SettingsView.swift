//
//  SettingsView.swift
//  MoviesApp
//
//  Created by lapshop on 6/29/23.
//

import Foundation
import SwiftUI


struct SettingsView : View {
    
    
    @ObservedObject var viewModel: SettingsViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        List {
            Section {
                
                Button {
                    viewModel.handleLoginOut()
                } label: {
                    HStack {
                        Image(systemName: "lock")
                        Text("Logout")
                            .font(.system(size: 15))
                            .bold()
                    }
                }
                
            } header: {
                HStack {
                    Image("profile")
                    Text("Settings")
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                        .bold()
                }
            }
        }
        .onChange(of:viewModel.logOutSucccess) { success in
            if success {
                dismiss()
            }
        }
        
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel(authService: AuthenticationService()))
    }
}


