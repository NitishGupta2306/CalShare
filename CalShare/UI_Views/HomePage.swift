//
//  HomePage.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 2/20/24.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationStack {
                ZStack {
                    VStack {
                        HStack {
                            //WILL NEED TO CHANGE THIS to take the groups and put them here
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
                            
                            Image(systemName: "calendar.badge.plus")
                                .foregroundColor(Color("PastelOrange"))
                                .padding(.leading, 10)
                                .font(.system(size: 30))
                        }
                        /*
                        Text("Home Page!")
                            .font(.custom(fontTwo, size: 40))
                            .foregroundColor(Color("TextColor"))
                        */
                        EventListView()
                        
                        HStack {
                            
                            Button {
                                CalendarViewModel.shared.fetchCurrentWeekEvents()
                            } label: {
                              Text("Request Calendar Data")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .background(Color("PastelOrange"))
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                .padding([.leading, .trailing], 20)
                                .padding(.bottom, 50)
                            }
                            /*
                            Button {
                                Task {
                                    await CalendarViewModel.shared.requestAccess()
                                }
                            }
                            label: {
                                Text("Request Calendar Data Access")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                                    .background(Color("PastelOrange"))
                                    .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                    .padding([.leading, .trailing], 20)
                            }
                            
                            Button {
                                self.goToSecondHomePage.toggle()
                            } label: {
                              Text("Go to Calendar")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .background(Color("PastelOrange"))
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                .padding([.leading, .trailing], 20)
                                .padding(.bottom, 50)
                            }
                             */
                            Button {
                                Task{
                                    try await DBViewModel.shared.addUserToGroup(groupID: "Test")
                                }
                            } label: {
                              Text("add user to group")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .background(Color("PastelOrange"))
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                .padding([.leading, .trailing], 20)
                                .padding(.bottom, 50)
                            }

                            Button {
                                Task{
                                    print("inside")
                                    let holder = try await DBViewModel.shared.getUserDataFromUsersInGroup(groupID: "0sQVzaOc41VyXQrAuuMH")
                                    
                                    print("preholder")
                                    print(holder)
                                }
                            } label: {
                              Text("getuserdatafromusersingroup")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .background(Color("PastelOrange"))
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                .padding([.leading, .trailing], 20)
                                .padding(.bottom, 50)
                            }
                        }
                        HomePageCopy()
                    }
                }
                .onTapGesture {
                    //Dismisses the keyboard if you click away
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .ignoresSafeArea(.keyboard)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("PastelBeige"))
        }
      
    }
      
}

#Preview {
    HomePage()
}



