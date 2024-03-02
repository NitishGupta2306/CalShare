//
//  CalendarModel.swift
//  CalShare
//
//  Created by Drew Helbig on 2/21/24.
//

import Foundation
import EventKit

struct IdentifiableEvent: Identifiable {
  let id = UUID()
  let event: EKEvent
}

@MainActor class CalendarViewModel: ObservableObject {
    @Published var events: [IdentifiableEvent]
    let store: EKEventStore

    init() {
        self.store = EKEventStore()
        self.events = []
    }
      
    func requestAccess() async {
        do {
          
          try await self.store.requestFullAccessToEvents()
          
        } catch {
          print("An error occured requesting calendar access.")
        }

    }

    func fetchEvents(interval: Calendar.Component, startDate: Date, calendars: [EKCalendar]?) {

        guard let interval = Calendar.current.dateInterval(of: interval, for: startDate)
        else {print("An error occured while creating a calendar interval."); return}

        let predicate = self.store.predicateForEvents(withStart: interval.start,
                                                      end: interval.end,
                                                      calendars: calendars)

        let fetchedEvents = self.store.events(matching: predicate).sorted(by: {$0.startDate < $1.startDate})

        self.events = fetchedEvents.map{ IdentifiableEvent(event: $0) }
        


    }

    func fetchCurrentWeekEvents(){
        self.fetchEvents(interval: .weekOfMonth, startDate: Date(), calendars: nil)
    }
    
    func convertDataToInt() -> [[Double]]{
        var unixTimeEvents: [[Double]] = [[]]
        for currEvent in self.events {
            let st = currEvent.event.startDate.timeIntervalSince1970
            let et = currEvent.event.endDate.timeIntervalSince1970
            
            unixTimeEvents.append([st,et])
        }
        return unixTimeEvents
    }


    func hasFullAccess() -> Bool {
        let authStatus = EKEventStore.authorizationStatus(for: EKEntityType.event)

        if authStatus == .fullAccess {
          return true
        } else {
          return false
        }
    }
        
}
