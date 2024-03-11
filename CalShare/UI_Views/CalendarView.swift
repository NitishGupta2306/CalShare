//
//  CalendarView.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 3/9/24.
//

import SwiftUI
import EventKit

struct CalendarView: View {
    let frameHeight: CGFloat = 50
    let textWidth: CGFloat = 40
    let lineWidth: CGFloat = 1
    @Binding var curDay: Date
  var body: some View {
      VStack {
          //Text(curDay.formatted())
          /*
          ForEach(CalendarViewModel.shared.getEventNames(), id: \.self) { ev_name in
              Text(ev_name)
          }
          
          ForEach(CalendarViewModel.shared.convertDataToDouble(), id: \.self) { date_info in
              Text("Time: \(date_info)")
          }
          */
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
                          .frame(height: lineWidth)
                  }
                  .frame(height: frameHeight)
                  ForEach(1..<12) { hour in
                      HStack {
                          Text("\(hour) am")
                              .frame(width: textWidth, alignment: .leading)
                              .font(.custom(fontTwo, size: 14.0))
                              .foregroundColor(Color("TextColor"))
                              .fontWeight(.regular)
                          Color("PastelGray")
                              .frame(height: lineWidth)
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
                          .frame(height: lineWidth)
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
                              .frame(height: lineWidth)
                      }
                      .frame(height: frameHeight)
                  }
                  HStack {
                      Text("12 am")
                          .frame(width: textWidth, alignment: .leading)
                          .font(.custom(fontTwo, size: 14.0))
                          .foregroundColor(Color("TextColor"))
                          .fontWeight(.regular)
                      Color("PastelGray")
                          .frame(height: lineWidth)
                  }
                  .frame(height: frameHeight)
              }
              //we will display all of the events on top of the zstack here
              
              //test: to display busy events, change what event list we are iterating through here
              ForEach(CalendarViewModel.shared.filterEventsByDayOfWeek(day: curDay)) { idEvent in
                  eventCell(curEv: idEvent.event)
                  //Text("\(formatDate(idEvent.event.startDate)) - \(formatDate(idEvent.event.endDate))")
              }
              
              /*
              ForEach(CalendarViewModel.shared.events) { idEvent in
                  eventCell(curEv: idEvent.event)
                  //Text("\(formatDate(idEvent.event.startDate)) - \(formatDate(idEvent.event.endDate))")
              }
              */
              /*
              Practice
              VStack(alignment: .leading) {
                  Text("Event Test")
              }
              .frame(maxWidth: 310, alignment: .leading)
              .frame(height: (frameHeight+7)*1.5, alignment: .top)
              .background(
                  RoundedRectangle(cornerRadius: 8)
                      .fill(Color("PastelOrange")).opacity(0.5)
              )
              .offset(x: textWidth + 8, y: ((frameHeight + 15) / 2 - 7) + ((frameHeight + 8) * 16))
              */
          }
        }
      .padding()
    }
  
    private func formatDate(_ date: Date, format: String = "h:mm a") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func eventCell(curEv: EKEvent) -> some View {
        let durationSecs = curEv.endDate.timeIntervalSince(curEv.startDate)
        let durationHr = durationSecs / 60 / 60
        print(durationHr)
        let initialOffset = (frameHeight + 15) / 2 - 7
        let frameOffsetHeight = frameHeight + 8
        print("\(curEv.title) and \(curEv.endDate) and \(curEv.startDate)")
        
        let calendar = Calendar.current
        var startCalendarDate = calendar.dateComponents([.day, .year, .month], from: curEv.startDate)
        startCalendarDate.hour = 0
        startCalendarDate.minute = 0
        var durationSinceMidnight = 0.0
        if let date = calendar.date(from: startCalendarDate) {
            print("test date \(date.formatted())")
            durationSinceMidnight = curEv.startDate.timeIntervalSince(date) / 60 / 60
            print("test duration\(durationSinceMidnight)")
            print("\(curEv.startDate.timeIntervalSince(curDay) / 60 / 60)")
        }
        
        return VStack(alignment: .center) {
            Text(curEv.title)
            Text("\(durationHr)")
            Text("\(durationSinceMidnight)")
        }
        .frame(maxWidth: 310, alignment: .leading)
        .frame(height: (frameHeight+7) * durationHr, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("PastelOrange")).opacity(0.5)
        )
        .offset(x: textWidth + 8, y: initialOffset + (frameOffsetHeight * durationSinceMidnight))
        .foregroundStyle(.black)
    }
    
}
#Preview {
    CalendarView(curDay: .constant(Date()))
}
