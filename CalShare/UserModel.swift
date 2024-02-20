//
//  UserModel.swift
//  CalShare
//
//  Created by Drew Helbig on 2/19/24.
//

import Foundation
import EventKit

class UserModel: ObservableObject {
    let store = EKEventStore()
    
    init() {
        Task{
            guard try await store.requestFullAccessToEvents() else {print("Access denied."); return}
            print("Access granted")
            
            guard let fetchCalendarInterval = Calendar.current.dateInterval(of: .month, for: Date()) else {print("Error fetching calendar data."); return}
            let predicate = store.predicateForEvents(withStart: fetchCalendarInterval.start,
                                                     end: fetchCalendarInterval.end,
                                                     calendars: nil)
            let events = store.events(matching: predicate)
            
            print(events)
        }
        
        
        
    }
}
