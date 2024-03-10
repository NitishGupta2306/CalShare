//
//  HomePageCopy.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 3/9/24.
//

import SwiftUI

struct HomePageCopy: View {
    @Namespace var animation
    @State var curDay: Date = Date()
    
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
                    Text(CalendarViewModel.shared.currentMonth)
                        .font(.custom(fontTwo, size: 30.0))
                        .foregroundColor(Color("TextColor"))
                        .padding(.top, 15)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(CalendarViewModel.shared.currentWeek, id: \.self) {day in
                                
                                VStack (spacing: 10){
                                    
                                    Text(CalendarViewModel.shared.extractDate(date: day, format: "dd"))
                                        .font(.custom(fontTwo, size: 15.0))
                                        .fontWeight(.semibold)
                                    //.foregroundColor(Color("TextColor"))
                                    
                                    //EEE formatting will return the day as MON
                                    Text(CalendarViewModel.shared.extractDate(date: day, format: "EEE").prefix(1))
                                        .font(.custom(fontTwo, size: 25.0))
                                        .fontWeight(.semibold)
                                    //.foregroundColor(Color("TextColor"))
                                    Circle()
                                        .fill(.white)
                                        .frame(width:8, height:8)
                                        .opacity(CalendarViewModel.shared.verifyIsToday(date:day) ? 1 : 0)
                                }
                                //.foregroundStyle(CalendarViewModel.shared.verifyIsToday(date:day) ? .primary : .tertiary)
                                .foregroundColor(Color("TextColor"))
                                .frame(width: 45, height: 90)
                                .background(
                                    ZStack {
                                        if CalendarViewModel.shared.verifyIsToday(date: day) {
                                            Capsule()
                                                .fill(Color("PastelOrange"))
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                        if day == curDay {
                                            Capsule()
                                                .fill(Color("PastelOrange"))
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    print("clicked")
                                    CalendarViewModel.shared.fetchCurrentDayEvents(day: day) //the events list is updated
                                    for ev in CalendarViewModel.shared.events {
                                        print(ev.event.title ?? "")
                                    }
                                    //we will be updating the current day here
                                    withAnimation {
                                        CalendarViewModel.shared.currentDay = day
                                        curDay = day
                                    }
                                    print(CalendarViewModel.shared.currentDay)
                                }
                            }
                        }
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
                    CalendarView(curDay: $curDay)
                }
            }
                /*
                .navigationDestination(isPresented: $addCal) {
                    CreateCalendarPage()
                        .navigationBarBackButtonHidden()
                }
                */
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
    HomePageCopy()
}
