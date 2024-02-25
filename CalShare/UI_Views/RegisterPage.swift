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
    @EnvironmentObject var curUser: UserModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("Register Now")
                        .font(Font.custom("Seymour", size: 40))
                        .foregroundColor(textColor1)
                    TextField("", text: $email)
                        .foregroundColor(Color("TextColor"))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("TextColor"), lineWidth: 0.5)
                                //.padding(10)
                        )
                        .frame(width: 300)
                        .overlay(
                                HStack {
                                    Image(systemName: "envelope")
                                        .foregroundColor(Color("TextColor"))
                                        .padding(.leading, 10)
                                    
                                    Text("Enter e-mail address")
                                        .foregroundColor(Color.gray)
                                        .padding(.leading, 5)
                                    
                                    Spacer() // Pushes the image and text to the leading edge
                                }
                            )

                    SecureField("", text: $password)
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
                                    
                                    Text("Enter Password")
                                        .foregroundColor(Color.gray)
                                        .padding(.leading, 10)
                                    
                                    Spacer() // Pushes the image and text to the leading edge
                                }
                        )
                    
                    Button ("Log In") {
                        print("We need to get a new user")
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
        .navigationDestination(isPresented: $goHomePage) {
            HomePage()
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
                            Text("CalShare").font(Font.custom("SeymourOne-Regular", size: 20))
                                .padding(.horizontal)
                                .foregroundColor(buttonColor)
                                .fontWeight(.bold)
                    }
                }
    }
}

#Preview {
    RegisterPage()
}
