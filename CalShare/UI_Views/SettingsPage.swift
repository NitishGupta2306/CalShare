//
//  SettingsPage.swift
//  CalShare
//
//  Created by Shubhada Martha on 2/27/24.
//

import SwiftUI

struct SettingsPage: View {
    @EnvironmentObject var curUser: UserModel
    @State var email: String = ""
    @State var password: String = ""
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
                    }
                }
            //}
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("PastelBeige"))
            Spacer()
        }
        .onTapGesture {
            //Dismisses the keyboard if you click away
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SettingsPage()
}
