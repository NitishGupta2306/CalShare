//
//  SettingsPage.swift
//  CalShare
//
//  Created by Shubhada Martha on 2/27/24.
//

import SwiftUI

struct SettingsPage: View {
    @EnvironmentObject var curUser: UserModel
    @State var email: String = "user_email"
    @State var password: String = "user_password"
    var body: some View {
        NavigationStack {
            //GeometryReader { _ in
                ZStack {
                    VStack {
                        HStack {
                            Image("LogoImage")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding(.horizontal)
                            Text("Hi User")
                                .font(Font.custom("SeymourOne-Regular", size: 40))
                                .foregroundColor(Color("TextColor"))
                        }
                        Text("E-mail Address")
                            .foregroundColor(Color("TextColor"))
                        TextField("", text: $email)
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
                                    Button {
                                        print("Edit password")
                                    } label: {
                                        Text("Edit")
                                            .foregroundColor(Color("PastelBeige"))
                                    }
                                    .background(Color("PastelOrange"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                    .frame(width: 50, height: 15)
                                }
                            )
                            .multilineTextAlignment(.center) // Center-align the entered text
                        
                        Text("Password")
                            .foregroundColor(Color("TextColor"))
                            .frame(width: 100, alignment: .leading)
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
                                    
//                                    Text("Enter Password")
//                                        .foregroundColor(Color.gray)
//                                        .padding(.leading, 10)
                                    
                                    Spacer() // Pushes the image and text to the leading edge
                                    Button {
                                        print("Edit password")
                                    } label: {
                                        Text("Edit")
                                            .foregroundColor(Color("PastelBeige"))
                                    }
                                    .background(Color("PastelOrange"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                    .frame(width: 50, height: 15)
                                }
                            )
                            .multilineTextAlignment(.center) // Center-align the entered text
                    }
                }
            //}
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
    SettingsPage()
}
