//
//  SignInView.swift
//  CalShare
//
//  Created by Nitish Gupta on 2/14/24.
//

import SwiftUI

@MainActor
final class SignUpViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws{
        guard !email.isEmpty, password.count > 7 else{
            // error handling
            throw AuthenticationError.signInError
        }
        
        let user = try await AuthenticationHandler.shared.createrNewUser(email: email, pass: password)
        print("USER CREATED, UID: \(user.uid)")
    }
}


struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack{
            TextField("Enter Email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(12)
            
            SecureField("Enter Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(12)
            
            Button{
                Task{
                    try await viewModel.signIn()
                }

                
            } label: {
                Text("Sign Up")
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
    SignUpView()
}
