//
//  addFriendsPage.swift
//  CalShare
//
//  Created by Shubhada Martha on 2/28/24.
//

import SwiftUI

struct addFriendsPage: View {
    @State var cancel: Bool = false
    @State var addedFriend: Bool = false
    
    var body: some View {
        NavigationStack {
            //GeometryReader { _ in
                ZStack {
                    VStack {
                        Text("Add Friends Page!")
                            .font(Font.custom("SeymourOne-Regular", size: 40))
                        .foregroundColor(Color("TextColor"))
                        
                        HStack {
                            Button ("Add Friend") {
                                //print("We are getting a new User and setting their information")
                                self.addedFriend.toggle()
                            }
                            .padding(.horizontal, 150)
                            .padding(.vertical, 20)
                            .background(Color("PastelOrange"))
                            .foregroundColor(Color("PastelBeige"))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            .frame(width: 400, height: 100)
                            
                            Button ("Cancel") {
                                //print("We are getting a new User and setting their information")
                                self.cancel.toggle()
                            }
                            .padding(.horizontal, 150)
                            .padding(.vertical, 20)
                            .background(Color("PastelOrange"))
                            .foregroundColor(Color("PastelBeige"))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            .frame(width: 400, height: 100)
                        }
                    }
                }
            //}
                .navigationDestination(isPresented: $cancel) {
                    CreateViewGroupsPage()
                        .navigationBarBackButtonHidden()
                }
                .navigationDestination(isPresented: $addedFriend) {
                    CreateViewGroupsPage()
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
    addFriendsPage()
}

