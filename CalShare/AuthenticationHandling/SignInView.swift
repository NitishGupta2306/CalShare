//
//  SignInView.swift
//  CalShare
//
//  Created by Nitish Gupta on 2/14/24.
//

import SwiftUI

final class SignInViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws{
        guard !email.isEmpty, password.count > 7 else{
            // error handling
            return
        }
        
       let userData = try await AuthenticationHandler.shared.createrNewUser(email: email, pass: password)
    }
}


struct SignInView: View {
    @StateObject private var view = SignInViewModel()
    
    var body: some View {
        VStack{
            TextField("Enter Email", text: $view.email)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(12)
            
            SecureField("Enter Password", text: $view.password)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(12)
            
            Button{
                Task{
                    try await view.signIn()
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
            }
            
        }
        .navigationTitle("Sign In Page:")
        .padding()
    }
}

#Preview {
    SignInView()
}
