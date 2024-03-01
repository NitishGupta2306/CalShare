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
                    VStack(alignment: .center) {
                        Spacer()
                        Text("Welcome!")
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
                                .multilineTextAlignment(.center) // Center-align the entered text
                                .padding()
                        }
                        
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
                        .padding(.horizontal, 150)
                        .padding(.vertical, 20)
                        .background(Color("PastelOrange"))
                        .foregroundColor(Color("PastelBeige"))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .frame(width: 400, height: 100)
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
    SignInPage()
}
