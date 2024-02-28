//
//  EventListView.swift
//  CalShare
//
//  Created by Drew Helbig on 2/28/24.
//

import SwiftUI

struct EventListView: View {
  @EnvironmentObject var calendar: CalendarViewModel
  
  var body: some View {
    
      ScrollView {
          ForEach(calendar.events) { idEvent in
            VStack(alignment: .center) {
                  Text("Event: \(idEvent.event.title)")
                  Text("Date: \(formatDate(idEvent.event.startDate, format: "MM d, yyyy"))")
                  Text("Start Time: \(formatDate(idEvent.event.startDate))")
                  Text("End Time: \(formatDate(idEvent.event.endDate))")
              }
              .foregroundStyle(.black)
              .padding()
            }
        }
    }
  
    private func formatDate(_ date: Date, format: String = "h:mm a") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}

#Preview {
    EventListView()
}
