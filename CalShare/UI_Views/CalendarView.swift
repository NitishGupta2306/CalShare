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
          Text(curDay.formatted())
          ForEach(CalendarViewModel.shared.getEventNames(), id: \.self) { ev_name in
              Text(ev_name)
          }
          
          ForEach(CalendarViewModel.shared.convertDataToDouble(), id: \.self) { date_info in
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
              }
              
              showEventCells(curEvs: CalendarViewModel.shared.events)
              /*
              Tester event block
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
        /*
        if curEvs.count == 0 {
            return VStack (alignment: .leading) {
                Text("Event")
            }
            .frame(maxWidth: 310, alignment: .leading)
            .frame(height: frameHeight+7, alignment: .leading)
            //the above frame shows the duration width
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("PastelOrange")).opacity(0.5)
            )
            .offset(x: textWidth + 8, y: ((frameHeight + 15) / 2 - 7) + frameHeight + 8)
        }
        */
        //let curDay = formatDate(curEv.startDate, format: "")
        let durationSecs = curEv.endDate.timeIntervalSince(curEv.startDate)
        let durationHr = durationSecs / 60 / 60
        let initialOffset = (frameHeight + 15) / 2 - 7
        let frameOffsetHeight = frameHeight + 8
        print("\(curEv.title) and \(curEv.endDate)")
        return VStack(alignment: .leading) {
            Text(curEv.title)
            Text("\(durationHr)")
        }
        .frame(maxWidth: 310, alignment: .leading)
        .frame(height: frameHeight+7, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("PastelOrange")).opacity(0.5)
        )
        .offset(x: textWidth + 8, y: initialOffset + (frameOffsetHeight * durationHr))
    }
    
    private func showEventCells(curEvs: [IdentifiableEvent]) -> some View {
        return VStack {
            ForEach(curEvs) { idEvent in
                eventCell(curEv: idEvent.event)
            }
        }
    }
    
    /*
    private func eventCell(curEvs: [IdentifiableEvent]) -> some View {
        if curEvs.count == 0 {
            return VStack (alignment: .leading) {
                Text("Event")
            }
            .frame(maxWidth: 310, alignment: .leading)
            .frame(height: textWidth * 1.5, alignment: .leading)
            //the above frame shows the duration width
            .background(
              RoundedRectangle(cornerRadius: 8)
                  .fill(Color("PastelOrange")).opacity(0.5)
            )
            .offset(x: textWidth, y: frameHeight * 1.5)
        }
        let curEv = curEvs[0].event
        let duration = curEv.endDate.timeIntervalSince(curEv.startDate)
        let height = (duration / 60 / 60)
        let offset_amt = 0
        return VStack(alignment: .leading) {
                 Text(curEv.title)
                 }
                .frame(maxWidth: 310, alignment: .leading)
                .padding(4)
                .frame(height: textWidth * 1.5 * height, alignment: .leading)
             //the above frame shows the duration width
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color("PastelOrange")).opacity(0.5)
                )
                .offset(x: textWidth, y: (frameHeight / 2))
        }
       */
}
#Preview {
    CalendarView(curDay: .constant(Date()))
}
