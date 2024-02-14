//
//  AuthView.swift
//  CalShare
//
//  Created by Nitish Gupta on 2/14/24.
//

import SwiftUI

struct AuthView: View {
    @State var isSignIn = false
    @State var isSignUp = false
    
    var body: some View {
        VStack{
            Button{
                isSignIn = true
            } label: {
                Text("Sign In")
            }
            
            Button{
                isSignUp = true
            } label: {
                Text("Sign Up")
            }
            
        }
        .navigationTitle("AuthView")
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isSignIn){SignUpView()}
        .navigationDestination(isPresented: $isSignUp){SignUpView()}
    }
}

#Preview {
    AuthView()
}
