//
//  EventListView.swift
//  CalShare
//
//  Created by Drew Helbig on 2/28/24.
//

import SwiftUI

struct EventListView: View {
//Unix time:
//
    
  var body: some View {
      ScrollView {
          ForEach(CalendarViewModel.shared.events) { idEvent in
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
