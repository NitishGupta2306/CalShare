//
//  HomePage.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 2/20/24.
//

import SwiftUI

struct HomePage: View {
    @State var addCal: Bool = false
    
    var body: some View {
        NavigationStack {
                ZStack {
                    VStack {
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
                            
                            Image(systemName: "calendar.badge.plus")
                                .foregroundColor(Color("PastelOrange"))
                                .padding(.leading, 10)
                                .font(.system(size: 30))
                        }
                      
                        Text("Landing Page!")
                            .font(.custom(fontTwo, size: 40))
                            .foregroundColor(Color("TextColor"))
                      
                        EventListView()
                      
                        Spacer()
                      
                        Button {
              
                          Task {
                            await CalendarViewModel.shared.requestAccess()
                          }
                          
                        } label: {
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
                        
                        Button {
              
                            Task{
                                await DBViewModel.shared.addUserToGroup(groupId: "TestGroup")
                            }
              
                        } label: {
                          Text("Try DB addUser")
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
                                try await DBViewModel.shared.createNewGroupAndAddCurrUser()
                            }
              
                        } label: {
                          Text("Try DB new group")
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
                }
                .navigationDestination(isPresented: $addCal) {
                    CreateCalendarPage()
                        .navigationBarBackButtonHidden()
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
