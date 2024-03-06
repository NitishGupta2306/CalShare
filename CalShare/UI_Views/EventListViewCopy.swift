//
//  EventListViewCopy.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 3/5/24.
//

import SwiftUI

struct EventListViewCopy: View {
    let colors: [Color] = [.red, .green, .blue]
    @Binding var curDay: Date
//Unix time:
//
    
  var body: some View {
      ScrollView {
          VStack {
              Text(curDay.formatted())
              ForEach(CalendarViewModel.shared.getEventNames(), id: \.self) { ev_name in
                  Text(ev_name)
              }
          }
          /*
          ForEach(CalendarViewModel.shared.events) { idEvent in
              Button {
                  print(idEvent)
              }
              label : {
                  Text(idEvent.event.title)
              }
              /*
            VStack(alignment: .center) {
                  Text("Event: \(idEvent.event.title)").bold()
                  Text("Date: \(formatDate(idEvent.event.startDate, format: "MM d, yyyy"))")
                  Text("Start Time: \(formatDate(idEvent.event.startDate))")
                  Text("End Time: \(formatDate(idEvent.event.endDate))")
              }
              .multilineTextAlignment(.center)
              .frame(maxWidth: .infinity)
              .background(Color("PastelOrange"))
              .foregroundStyle(.black)
              .clipShape(RoundedRectangle(cornerRadius: 5))
              .padding([.leading, .trailing, .bottom], 20)
               */
            }
           */
        }
    }
  
    private func formatDate(_ date: Date, format: String = "h:mm a") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}

#Preview {
    EventListViewCopy(curDay: .constant(Date()))
}

