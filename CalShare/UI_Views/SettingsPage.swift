//
//  SettingsPage.swift
//  CalShare
//
//  Created by Shubhada Martha on 2/27/24.
//

import SwiftUI

@MainActor
final class SettingViewModel: ObservableObject{
    var email = ""
    var password = ""
    var errMsg = ""
    func logOut(){
        Task{
            do{
                try AuthenticationHandler.shared.signOut()
            }
            catch{
                throw AuthenticationError.signOutError
            }
        }
    }
    
    func resetPass() async throws {
        let currentUser = try AuthenticationHandler.shared.checkAuthenticatedUser()
        
        guard let email = currentUser.email else {
            throw AuthenticationError.getUserFail
        }
        
        do{
            try await AuthenticationHandler.shared.passReset(email: email)
        } catch {
            throw AuthenticationError.passResetError
        }
    }
    
    func updatePass() async throws{
        if(self.password.count > 7){
            try await AuthenticationHandler.shared.updatePass(password: self.password)
        }
        else{
            self.errMsg = "Not a valid password."
        }
    }
    
}

struct SettingsPage: View {
    @StateObject private var viewModel = SettingViewModel()
    
    @State var isSignedOut: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    VStack(alignment: .leading, spacing: 5) {
                        List{
                            // Logout Button
                            Button{
                                viewModel.logOut()
                                isSignedOut.toggle()
                                
                            }label: {
                                Text("Logout")
                            }
                            
                            // Reset password
                            Button{
                                Task{
                                    try await viewModel.resetPass()
                                }
                            }label: {
                                Text("Reset Password")
                            }
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isSignedOut) {
                SignInPage()
                    .navigationBarBackButtonHidden()
            }
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    SettingsPage()
}
