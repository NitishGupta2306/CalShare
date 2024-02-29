//
//  CreateViewGroupsPage.swift
//  CalShare
//
//  Created by Shubhada Martha on 2/27/24.
//

import SwiftUI

struct CreateViewGroupsPage: View {
    @State var addCal: Bool = false
    @State var addFriend: Bool = false
    
    var body: some View {
        NavigationStack {
            //GeometryReader { _ in
                ZStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Spacer()
                        
                        Text("Calendars")
                            .font(.custom(fontTwo, size: 30.0))
                            .foregroundColor(Color("PastelGray"))
                            .fontWeight(.regular)
                        
                        HStack { //WILL NEED TO CHANGE THIS to take the groups and put them here
                            Image(systemName: "person.3.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Color("PastelOrange"))
                                .padding(.leading, 10)
                            
                            Image(systemName: "person.3.fill")
                                .foregroundColor(Color("PastelOrange"))
                                .padding(.leading, 10)
                                .font(.system(size: 30))
                            
                            Image(systemName: "person.3.fill")
                                .foregroundColor(Color("PastelOrange"))
                                .padding(.leading, 10)
                                .font(.system(size: 30))
                            
                            Button {
                                print("Add Calendar")
                                self.addCal.toggle()
                            } label: {
                                Image(systemName: "calendar.badge.plus")
                                    .foregroundColor(Color("PastelOrange"))
                                    .padding(.leading, 10)
                                    .font(.system(size: 30))
                            }
                            
                        }
                        .padding()
                        
                        Text("Friends")
                            .font(.custom(fontTwo, size: 30.0))
                            .foregroundColor(Color("PastelGray"))
                            .fontWeight(.regular)
                        
                        HStack(spacing: 10) {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(Color("PastelOrange"))
                                .padding(.leading, 10)
                            
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(Color("PastelOrange"))
                                .padding(.leading, 10)
                                .font(.system(size: 40))
                            
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(Color("PastelOrange"))
                                .padding(.leading, 10)
                                .font(.system(size: 40))
                            
                            Button {
                                print("Add Calendar")
                                self.addFriend.toggle()
                            } label: {
                                Image(systemName: "person.fill.badge.plus")
                                    .foregroundColor(Color("PastelOrange"))
                                    .padding(.leading, 10)
                                    .font(.system(size: 30))
                            }
                        }
                        Spacer()
                    }
                }
            //}
                .navigationDestination(isPresented: $addCal) {
                    CreateCalendarPage()
                        .navigationBarBackButtonHidden()
                }
                .navigationDestination(isPresented: $addFriend) {
                    addFriendsPage()
                        .navigationBarBackButtonHidden()
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
    CreateViewGroupsPage()
}
