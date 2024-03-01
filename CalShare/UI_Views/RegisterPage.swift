//
//  RegisterPage.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 2/20/24.
//

import SwiftUI

struct RegisterPage: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var goHomePage: Bool = false
    @State var goLogInPage: Bool = false
    @EnvironmentObject var curUser: UserModel
    
    var body: some View {
        NavigationStack {
            GeometryReader { _ in
                ZStack {
                    VStack(alignment: .center) {
                        Spacer()
                        Text("Register Now")
                            .font(.custom(fontTwo, size: 30.0))
                            .foregroundColor(Color("TextColor"))
                            .fontWeight(.semibold)
                            .padding()
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("E-mail Address")
                                .font(.custom(fontTwo, size: 14.0))
                                .foregroundColor(Color("PastelGray"))
                                .fontWeight(.regular)
                            
                            TextField("*****@gmail.com", text: $email)
                                .foregroundColor(Color("PastelGray"))
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color("TextColor"), lineWidth: 0.5)
                                        .frame(height: 40)
                                )
                                .frame(width: 300)
                                .overlay(
                                    HStack {
                                        Image(systemName: "envelope")
                                            .foregroundColor(Color("PastelGray"))
                                            .padding(.leading, 10)
                                        
                                        Spacer() // Pushes the image and text to the leading edge
                                    }
                                )
                                .ignoresSafeArea(.keyboard)
                                .padding()
                                .multilineTextAlignment(.center) // Center-align the entered text
                            
                            Text("Password")
                                .font(.custom(fontTwo, size: 14.0))
                                .foregroundColor(Color("PastelGray"))
                                .fontWeight(.regular)
                            
                            
                            SecureField("**********", text: $password)
                                .foregroundColor(Color("PastelGray"))
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color("TextColor"), lineWidth: 0.5)
                                        .frame(height: 40)
                                )
                                .frame(width: 300)
                                .overlay(
                                    HStack {
                                        Image(systemName: "lock")
                                            .foregroundColor(Color("PastelGray"))
                                            .padding(.leading, 10)
                                        
                                        Spacer() // Pushes the image and text to the leading edge
                                    }
                                )
                                .ignoresSafeArea(.keyboard)
                                .multilineTextAlignment(.center) // Center-align the entered text
                                .padding()
                        }
                        
                        Button {
                            print("We need to get a new user")
                            self.goLogInPage.toggle()
                        } label: {
                            Text("Already have an account?")
                                .foregroundColor(Color("TextColor"))
                        }
                        
                        Button ("Get Started") {
                            print("We need to get a new user")
                            self.goHomePage.toggle()
                            // Dismisses the keyboard when the "Send Code" button is tapped
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        .padding(.horizontal, 120)
                        .padding(.vertical, 20)
                        .background(Color("PastelOrange"))
                        .foregroundColor(Color("PastelBeige"))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .frame(width: 400, height: 100)
                        Spacer()
                    }
                }
            }
            .navigationDestination(isPresented: $goHomePage) {
                ContentViewPage()
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $goLogInPage) {
                SignInPage()
                    .navigationBarBackButtonHidden()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("LogoImage")
                        .resizable()
                        .frame(width:60, height: 60)
                }
                ToolbarItem(placement: .principal) {
    //                    Text("CalShare")
    //                        .foregroundStyle(Color("PastelOrange"))
                    Image("CalShare")
                        .resizable()
                        .frame(width: 130, height: 20)
                }
            }
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("PastelBeige"))
        }
        .onTapGesture {
            //Dismisses the keyboard if you click away
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    RegisterPage()
}
