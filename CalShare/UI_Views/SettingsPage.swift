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
                                    .foregroundColor(Color("TextColor"))
                            }
                            
                            // Reset password
                            Button{
                                Task{
                                    try await viewModel.resetPass()
                                }
                            }label: {
                                Text("Reset Password")
                                    .foregroundColor(Color("TextColor"))
                            }
                        }
                    }
                }
                .background(Color("PastelBeige"))

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

/*
struct SettingsPage: View {
    @StateObject private var viewModel = SettingViewModel()
    @EnvironmentObject var curUser: UserModel
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isSignedOut: Bool = false

    
    let username = "Sarah"
    var body: some View {
        NavigationStack {
            //GeometryReader { _ in
                ZStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Spacer()
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(Color("TextColor"))
                                .padding(.leading, 10)
                                .font(.system(size: 40))
                            Text("Hi, \(username)")
                                .font(Font.custom("fontTwo", size: 40))
                                .foregroundColor(Color("TextColor"))
                        }.padding()
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("E-mail Address")
                                .font(.custom(fontTwo, size: 14.0))
                                .foregroundColor(Color("PastelGray"))
                                .fontWeight(.regular)
                            
                            TextField("*****@gmail.com", text: $email)
                                .foregroundColor(Color("TextColor"))
                                .autocorrectionDisabled()
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color("TextColor"), lineWidth: 0.5)
                                        .frame(height: 40)
                                )
                                .frame(width: 300)
                                .overlay(
                                    HStack {
                                        Image(systemName: "envelope")
                                            .foregroundColor(Color("TextColor"))
                                            .padding(.leading, 10)
                                        Spacer() // Pushes the image and text to the leading edge
                                    }
                                )
                                .overlay(
                                    Button("Edit"){
                                        print("Edit username")
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(Color("PastelOrange"))
                                    .foregroundColor(Color("PastelBeige"))
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                    .frame(width: 400, height: 100)
                                    .padding(.trailing, -170), // Adjust the position of the button as needed
                                        alignment: .trailing // Position the button to the trailing edge
                                    )
                                .multilineTextAlignment(.center) // Center-align the entered text
                                .padding()
                            
                            Text("Password")
                                .font(.custom(fontTwo, size: 14.0))
                                .foregroundColor(Color("PastelGray"))
                                .fontWeight(.regular)
                            
                            SecureField("**********", text: $password)
                                .foregroundColor(Color("TextColor"))
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color("TextColor"), lineWidth: 0.5)
                                        .frame(height: 40)
                                )
                                .frame(width: 300)
                                .overlay(
                                    HStack {
                                        Image(systemName: "lock")
                                            .foregroundColor(Color("TextColor"))
                                            .padding(.leading, 10)
                                        Spacer() // Pushes the image and text to the leading edge
                                    }
                                )
                                .overlay(
                                    Button("Edit"){
                                        print("Edit password")
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(Color("PastelOrange"))
                                    .foregroundColor(Color("PastelBeige"))
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                    .frame(width: 400, height: 100)
                                    .padding(.trailing, -170), // Adjust the position of the button as needed
                                        alignment: .trailing // Position the button to the trailing edge
                                    )
                                .multilineTextAlignment(.center) // Center-align the entered text
                                .padding()
                        }
                        Spacer()
                        //LOGOUT:
                        VStack{
                            Button{
                                viewModel.logOut()
                                isSignedOut.toggle()
                                
                            }label: {
                                Text("Logout")
                                    .foregroundColor(Color("TextColor"))
                            }
                        }
                        .padding(.horizontal, 120)
                        .padding(.vertical, 20)
                        .background(Color("PastelOrange"))
                        .foregroundColor(Color("PastelBeige"))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .frame(width: 400, height: 100)
                        Spacer()
                        Spacer()
                    }
                }
            //}
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("PastelBeige"))
            Spacer()
            .navigationDestination(isPresented: $isSignedOut) {
                SignInPage()
                    .navigationBarBackButtonHidden()
            }
        }
        .onTapGesture {
            //Dismisses the keyboard if you click away
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
 */

#Preview {
    SettingsPage()
}
