//
//  ContentView.swift
//  CalShare
//
//  Created by Nitish Gupta on 1/19/24.
//

import SwiftUI

struct LandingPage: View {
  @StateObject var calendar = CalendarViewModel()
  
    var body: some View {
        ZStack{
            Color(.white)
                .ignoresSafeArea()
            
            VStack{
              Spacer()
              
              Text("You are on the landing page.")
                .foregroundStyle(.black)
              
              Spacer()
              
              Button {
                Task{
                  await calendar.requestAccess()
                }
              } label: {
                Text("Request Access to Calendar")
                  .frame(maxWidth: .infinity)
                  .frame(height: 40)
                  .font(.system(size: 20))
                  .foregroundColor(.black)
                  .background(.green)
                  .clipShape(RoundedRectangle(cornerRadius: 5.0))
                  .padding([.leading, .trailing], 20)
              }
              Button {
                
                calendar.fetchEvents(interval: Calendar.Component.day, startDate: Date(), calendars: nil)
                
              } label: {
                Text("Fetch Calendar Events")
                  .frame(maxWidth: .infinity)
                  .frame(height: 40)
                  .font(.system(size: 20))
                  .foregroundColor(.black)
                  .background(.green)
                  .clipShape(RoundedRectangle(cornerRadius: 5.0))
                  .padding([.leading, .trailing], 20)
              }
            }
            
        }
    }
}

#Preview {
    LandingPage()
    .environmentObject(CalendarViewModel())
}
