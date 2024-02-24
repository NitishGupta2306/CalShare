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
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Register Now")
                    .font(Font.custom("Seymour", size: 40))
                    .foregroundColor(textColor1)
                TextField("Enter e-mail address", text: $email)
                TextField("Enter password", text: $password)
                Button {
                    print("We need to get a new user")
                    self.goHomePage.toggle()
                } label: {
                  Text("Log In")
                        .foregroundColor(textColor1)
                        .background(buttonColor)
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .cornerRadius(20)
                Spacer()
            }
        }
        .navigationDestination(isPresented: $goHomePage) {
            HomePage()
                .navigationBarBackButtonHidden()
        }
        .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            Image("LogoImage")
                                .resizable()
                                .frame(width:60, height: 60)
                            Text("CalShare").font(Font.custom("Seymour", size: 20))
                                .padding(.horizontal)
                                .foregroundColor(buttonColor)
                                .fontWeight(.bold)
                        }
                    }
                }
    }
}

#Preview {
    RegisterPage()
}
