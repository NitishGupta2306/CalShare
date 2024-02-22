//
//  CalendarModel.swift
//  CalShare
//
//  Created by Drew Helbig on 2/21/24.
//

import Foundation
import EventKit

@MainActor class CalendarViewModel: ObservableObject {
  @Published var calendarEvents: [EKEvent]?
  let store: EKEventStore
    
  init() {
    
    self.store = EKEventStore()
    
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
    
    self.calendarEvents = self.store.events(matching: predicate).sorted(by: {$0.startDate < $1.startDate})
    print(self.calendarEvents ?? "nil")
    
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
