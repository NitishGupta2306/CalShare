//
//  RootView.swift
//  CalShare
//
//  Created by Nitish Gupta on 2/14/24.
//

import SwiftUI

struct RootView: View {
    @State private var isSignedIn = false

    var body: some View {
        ZStack{
            SettingsView(isSignedIn: $isSignedIn)
        }
        .onAppear{
            // "try?" to set the default error to nill
            let authenticatedUser = try? AuthenticationHandler.shared.checkAuthenticatedUser()
            isSignedIn = authenticatedUser == nil
        }
        .navigationDestination(isPresented: $isSignedIn){
            AuthView()
        }
        
    }
}

#Preview {
    RootView()
}
