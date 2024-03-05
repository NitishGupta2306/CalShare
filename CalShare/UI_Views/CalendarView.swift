//
//  CalendarView.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 3/4/24.
//

import SwiftUI

struct CalendarView: View {
    @Namespace var animation
    @State var curDay: Date = Date()
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    //this is to look at the current week view
                    //we only see one week at a time
                    Text(CalendarViewModel.shared.currentMonth)
                        .font(.custom(fontTwo, size: 30.0))
                        .foregroundColor(Color("TextColor"))
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
                        .padding(.horizontal)
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
                    EventListViewCopy(curDay: $curDay)
                }
            }
            .background(Color("PastelBeige"))
        }
    }
}

#Preview {
    CalendarView()
}
