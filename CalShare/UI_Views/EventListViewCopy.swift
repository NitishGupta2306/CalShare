//
//  EventListViewCopy.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 3/5/24.
// How to add event blocks in calendar: https://stackoverflow.com/questions/76213682/create-a-daily-timeline-calendar-in-swiftui
//

import SwiftUI
import EventKit

struct EventListViewCopy: View {
    let frameHeight: CGFloat = 50
    let textWidth: CGFloat = 40
    @Binding var curDay: Date
  var body: some View {
      VStack {
          Text(curDay.formatted())
          ForEach(CalendarViewModel.shared.getEventNames(), id: \.self) { ev_name in
              Text(ev_name)
          }
          
          ForEach(CalendarViewModel.shared.convertDataToInt(), id: \.self) { date_info in
              Text("Time: \(date_info)")
          }
      }
      ScrollView {
          ZStack (alignment: .topLeading) {
              VStack (alignment: .leading) {
                  HStack {
                      Text("\(12) am")
                          .frame(width: textWidth, alignment: .leading)
                          .font(.custom(fontTwo, size: 14.0))
                          .foregroundColor(Color("TextColor"))
                          .fontWeight(.regular)
                      Color("PastelGray")
                          .frame(height: 1)
                  }
                  .frame(height: frameHeight)
                  ForEach(1..<11) { hour in
                      HStack {
                          Text("\(hour) am")
                              .frame(width: textWidth, alignment: .leading)
                              .font(.custom(fontTwo, size: 14.0))
                              .foregroundColor(Color("TextColor"))
                              .fontWeight(.regular)
                          Color("PastelGray")
                              .frame(height: 1)
                      }
                      .frame(height: frameHeight)
                  }
                  HStack {
                      Text("12 pm")
                          .frame(width: textWidth, alignment: .leading)
                          .font(.custom(fontTwo, size: 14.0))
                          .foregroundColor(Color("TextColor"))
                          .fontWeight(.regular)
                      Color("PastelGray")
                          .frame(height: 1)
                  }
                  .frame(height: frameHeight)
                  ForEach(1..<12) { hour in
                      HStack {
                          Text("\(hour) pm")
                              .frame(width: textWidth, alignment: .leading)
                              .font(.custom(fontTwo, size: 14.0))
                              .foregroundColor(Color("TextColor"))
                              .fontWeight(.regular)
                          Color("PastelGray")
                              .frame(height: 1)
                      }
                      .frame(height: frameHeight)
                  }
              }
              
              VStack (alignment: .leading) {
                  Text("Event")
              }
              .frame(maxWidth: 310, alignment: .leading)
              .padding(4)
              .frame(height: textWidth * 1.5 * 1.5, alignment: .leading)
              //the above frame shows the duration width
              .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("PastelOrange")).opacity(0.5)
              )
              .padding(4)
              .offset(x: textWidth, y: textWidth / 2)
          }
        }
      .padding()
    }
  
    private func formatDate(_ date: Date, format: String = "h:mm a") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    private func eventCell(curEv: EKEvent) -> some View {
        let duration = curEv.startDate.timeIntervalSince(curEv.endDate)
        let height = duration / 60 / 60 * frameHeight
        return VStack(alignment: .leading) {
                Text(curEv.title)
                }
        .frame(maxWidth: 310, alignment: .leading)
        .padding(4)
        .frame(height: textWidth * 1.5 * duration, alignment: .leading)
        //the above frame shows the duration width
        .background(
          RoundedRectangle(cornerRadius: 8)
              .fill(Color("PastelOrange")).opacity(0.5)
        )
        .padding(4)
        .offset(x: textWidth, y: textWidth / 2)

        }
            
}

#Preview {
    EventListViewCopy(curDay: .constant(Date()))
}

