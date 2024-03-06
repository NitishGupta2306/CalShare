//
//  EventListView.swift
//  CalShare
//
//  Created by Drew Helbig on 2/28/24.
//

import SwiftUI

struct EventListView: View {
    
    @ObservedObject var viewModel = CalendarViewModel.shared
    
    var body: some View {
      ScrollView {
          ForEach(viewModel.eventsToDisplay) { idEvent in
            VStack(alignment: .center) {
                Text("\(formatDate(idEvent.event.startDate, format: "EEE"))").bold()
                Text("\(formatDate(idEvent.event.startDate, format: "MM-d-yyyy"))")
                Text("\(formatDate(idEvent.event.startDate)) - \(formatDate(idEvent.event.endDate))")
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
