import SwiftUI
import EventKit

struct CalendarView: View {
    @Binding var curDay: Date
    
    let frameHeight: CGFloat = 50
    let textWidth: CGFloat = 40
    let lineWidth: CGFloat = 1
    
  var body: some View {
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
                  eventCell(curEv: idEvent)
              }
          }
        }
      .padding()
    }
  
    private func formatDate(_ date: Date, format: String = "h:mm a") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func eventCell(curEv: IdentifiableEvent) -> some View {
        let durationSecs = curEv.event.endDate.timeIntervalSince(curEv.event.startDate)
        let durationHr = durationSecs / 60 / 60
        let initialOffset = (frameHeight + 15) / 2 - 7
        let frameOffsetHeight = frameHeight + 8
        let calendar = Calendar.current
        var startCalendarDate = calendar.dateComponents([.day, .year, .month], from: curEv.event.startDate)
        
        startCalendarDate.hour = 0
        startCalendarDate.minute = 0
        
        var durationSinceMidnight = 0.0
        
        if let date = calendar.date(from: startCalendarDate) {
            durationSinceMidnight = curEv.event.startDate.timeIntervalSince(date) / 60 / 60
        }
        
        return VStack(alignment: .center) {
            Text(curEv.event.title)
            Text(curEv.timeSlot)
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
