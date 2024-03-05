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
                      
                        Text("Home Page!")
                            .font(.custom(fontTwo, size: 40))
                            .foregroundColor(Color("TextColor"))
                      
                        EventListView()
                        //CalendarView()
                        Spacer()
                        Button {
                            self.addCal.toggle()
                        }
                        label: {
                            Text("Go to Calendar Page")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .background(Color("PastelOrange"))
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                .padding([.leading, .trailing], 20)
                            
                        }
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
              
                            CalendarViewModel.shared.fetchCurrentWeekEvents()
                            for ev in CalendarViewModel.shared.events {
                                print(ev.event.title)
                            }
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
                    }
                }
                .navigationDestination(isPresented: $addCal) {
                    //CreateCalendarPage()
                    CalendarView()
                        //.navigationBarBackButtonHidden()
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
    private func formatDate(_ date: Date, format: String = "h:mm a") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
      
}

#Preview {
    HomePage()
}
