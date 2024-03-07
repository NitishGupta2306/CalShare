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
      VStack {
          Text(curDay.formatted())
          ForEach(CalendarViewModel.shared.getEventNames(), id: \.self) { ev_name in
              Text(ev_name)
          }
      }
      ScrollView {
          ZStack {
              VStack {
                  HStack {
                      Text("\(12) am")
                          .frame(width: 40, alignment: .leading)
                          .font(.custom(fontTwo, size: 14.0))
                          .foregroundColor(Color("TextColor"))
                          .fontWeight(.regular)
                      Color("PastelGray")
                          .frame(height: 1)
                  }
                  .frame(height: 50)
                  ForEach(1..<11) { hour in
                      HStack {
                          Text("\(hour) am")
                              .frame(width: 40, alignment: .leading)
                              .font(.custom(fontTwo, size: 14.0))
                              .foregroundColor(Color("TextColor"))
                              .fontWeight(.regular)
                          Color("PastelGray")
                              .frame(height: 1)
                      }
                      .frame(height: 50)
                  }
                  HStack {
                      Text("12 pm")
                          .frame(width: 40, alignment: .leading)
                          .font(.custom(fontTwo, size: 14.0))
                          .foregroundColor(Color("TextColor"))
                          .fontWeight(.regular)
                      Color("PastelGray")
                          .frame(height: 1)
                  }
                  .frame(height: 50)
                  ForEach(1..<12) { hour in
                      HStack {
                          Text("\(hour) pm")
                              .frame(width: 40, alignment: .leading)
                              .font(.custom(fontTwo, size: 14.0))
                              .foregroundColor(Color("TextColor"))
                              .fontWeight(.regular)
                          Color("PastelGray")
                              .frame(height: 1)
                      }
                      .frame(height: 50)
                  }
              }
              
              VStack (alignment: .leading) {
                  Text("Event")
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(4)
              .frame(height: 80, alignment: .top)
              .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.teal).opacity(0.5)
              )
              .padding(.trailing, 30)
              .offset(x: 30, y: 30 + 24)
          }
        }
      .padding()
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

