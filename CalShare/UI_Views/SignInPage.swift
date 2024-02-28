//
//  ContentView.swift
//  CalShare
//
//  Created by Nitish Gupta on 1/19/24.
//

import SwiftUI


struct SignInPage: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var newUser: Bool = false
    @State var goHomePage: Bool = false
    @EnvironmentObject var curUser: UserModel

    
    var body: some View {
        NavigationStack{
            GeometryReader { _ in
                ZStack {
//                    backgroundColor
//                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        Text("Welcome!")
                            .font(Font.custom("SeymourOne-Regular", size: 40))
                            .foregroundColor(Color("TextColor"))
                            .bold()
                        
                        TextField("Enter e-mail address", text: $email)
                            .foregroundColor(Color("TextColor"))
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("TextColor"), lineWidth: 0.5)
//                                .padding(10)
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
                            .multilineTextAlignment(.center) // Center-align the entered text
                        
                        Button {
                            print("We need to get a new user")
                            self.newUser.toggle()
                        } label: {
                            Text("New User?")
                                .foregroundColor(Color("TextColor"))
                        }
                        
                        Button ("Log In") {
                            //print("We are getting a new User and setting their information")
                            curUser.setEmail(email_string: email)
                            curUser.setPassword(password_string: password)
                            self.goHomePage.toggle()
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
            .navigationDestination(isPresented: $newUser) {
                RegisterPage()
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $goHomePage) {
                ContentViewPage()
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
    SignInPage()
}
