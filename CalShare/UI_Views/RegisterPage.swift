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
//                    backgroundColor
//                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        Text("Register Now")
                            .font(Font.custom("SeymourOne-Regular", size: 40))
                            .foregroundColor(Color("TextColor"))
                        
                        TextField("Enter e-mail address", text: $email)
                            .foregroundColor(Color("TextColor"))
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("TextColor"), lineWidth: 0.5)
                            )
                            .frame(width: 300)
                            .overlay(
                                HStack {
                                    Image(systemName: "envelope")
                                        .foregroundColor(Color("TextColor"))
                                        .padding(.leading, 10)
                                    
//                                    Text("Enter e-mail address")
//                                        .foregroundColor(Color.gray)
//                                        .padding(.leading, 5)
                                    
                                    Spacer() // Pushes the image and text to the leading edge
                                }
                            )
                            .ignoresSafeArea(.keyboard)
                            .padding()
                            .multilineTextAlignment(.center) // Center-align the entered text
                        
                        SecureField("Enter Password", text: $password)
                            .foregroundColor(Color("TextColor"))
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("TextColor"), lineWidth: 0.5)
                            )
                            .frame(width: 300)
                            .overlay(
                                HStack {
                                    Image(systemName: "lock")
                                        .foregroundColor(Color("TextColor"))
                                        .padding(.leading, 10)
                                    
//                                    Text("Enter Password")
//                                        .foregroundColor(Color.gray)
//                                        .padding(.leading, 10)
                                    
                                    Spacer() // Pushes the image and text to the leading edge
                                }
                            )
                            .ignoresSafeArea(.keyboard)
                            .multilineTextAlignment(.center) // Center-align the entered text
                        
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
                        .padding(20)
                        .background(Color("PastelOrange"))
                        .foregroundColor(Color("PastelBeige"))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .frame(width:400, height: 200)
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
            .onTapGesture {
                //Dismisses the keyboard if you click away
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("PastelBeige"))
        }
    }
}

#Preview {
    RegisterPage()
}
