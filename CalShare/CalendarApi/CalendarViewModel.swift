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
    static let shared = CalendarViewModel()
    
    @Published var eventsToDisplay: [IdentifiableEvent] = []
    var events: [IdentifiableEvent] = []
    let store: EKEventStore

    init() {
        self.store = EKEventStore()
        self.events = []
    }
      
    func requestAccess() async {
        do {
          
          try await CalendarViewModel.shared.store.requestFullAccessToEvents()
          
        } catch {
          print("An error occured requesting calendar access.")
        }

    }

    func fetchEvents(interval: Calendar.Component, startDate: Date, calendars: [EKCalendar]?) {

        guard let interval = Calendar.current.dateInterval(of: interval, for: startDate)
        else { print("An error occured while creating a calendar interval."); return }

        let predicate = CalendarViewModel.shared.store.predicateForEvents(withStart: interval.start, end: interval.end, calendars: calendars)

        let fetchedEvents = CalendarViewModel.shared.store.events(matching: predicate).sorted(by: {$0.startDate < $1.startDate})
        
        CalendarViewModel.shared.events = fetchedEvents.map{ IdentifiableEvent(event: $0) }
        
        createFreeTimeSlotEvents()
    }

    func fetchCurrentWeekEvents(){
        CalendarViewModel.shared.fetchEvents(interval: .weekOfMonth, startDate: Date(), calendars: nil)
    }
    
    func convertDataToDouble() -> [Double]{
        var unixTimeEvents: [Double] = []
        
        for currEvent in CalendarViewModel.shared.events {
            let st = currEvent.event.startDate.timeIntervalSince1970
            let et = currEvent.event.endDate.timeIntervalSince1970
            
            unixTimeEvents.append(st)
            unixTimeEvents.append(et)
        }
        return unixTimeEvents
    }
    
    func getWeekStartAndEndTime() -> (Double, Double) {
        let now = Date()
        let calendar = Calendar.current
        var startOfWeek = Date()
        var interval: TimeInterval = 0
        let _ = calendar.dateInterval(of: .weekOfYear, start: &startOfWeek, interval: &interval, for: now)
        
        if let endOfWeek = calendar.date(byAdding: .second, value: Int(interval), to: startOfWeek){
            let startOfWeekSince1970 = startOfWeek.timeIntervalSince1970
            let endOfWeekSince1970 = endOfWeek.timeIntervalSince1970
            
            print("Start of the week: \(startOfWeekSince1970)")
            print("End of the week: \(endOfWeekSince1970)")
            
            return (startOfWeekSince1970, endOfWeekSince1970)
        }
        
        return (0,0)
    }
    
    func findTakenTimeSlots(times: [Double]) -> [(Double, Double)] {
        
        var pairs: [(Double, Double)] = []
        
        for i in stride(from: 0, to: times.count, by: 2) {
            let pair = (times[i], times[i+1])
            pairs.append(pair)
        }
        
        pairs.sort { $0.0 < $1.0 }
        
        guard let _ = pairs.last else { return [] }
        
        var earliestStart = pairs[0].0
        var latestEnd = pairs[0].1
        var takenTimeSlots: [(Double, Double)] = []
        
        for p in pairs{
            
            if p.0 > latestEnd {
                takenTimeSlots.append((earliestStart, latestEnd))
                earliestStart = p.0
                latestEnd = p.1
            } else if p.0 <= latestEnd && p.1 > latestEnd {
                latestEnd = p.1
            }
            
        }
        
        if let lastPair = takenTimeSlots.last {
            if earliestStart > lastPair.1 {
                takenTimeSlots.append((earliestStart, latestEnd))
            }
        } else {
            takenTimeSlots.append((earliestStart, latestEnd))
        }
        
        return takenTimeSlots
    }
    
    func createTimeIntervals(interevalInMinutes: Double = 24 * 60, freeTimeSlot: (Double, Double)) -> [(Double, Double)] {
        var timeIntervals: [(Double, Double)] = []
        let secondsInterval = interevalInMinutes * 60
        let totalTimeIntervals = (freeTimeSlot.1 - freeTimeSlot.0) / secondsInterval
        
        var nextInterval = freeTimeSlot.0
        
        if Int(totalTimeIntervals) > 0 {
            
            for _ in 1...Int(ceil(totalTimeIntervals)) {
                
                if nextInterval + secondsInterval <= freeTimeSlot.1 {
                    timeIntervals.append((nextInterval, nextInterval + secondsInterval - 60)) // - 60 is just for readability when time intervals are days should be removed if any other time interval is used
                    nextInterval += secondsInterval
                } else {
                    timeIntervals.append((nextInterval, freeTimeSlot.1))
                }
                
            }
        } else {
            timeIntervals.append(freeTimeSlot)
        }
        
        return timeIntervals
    }
    
    func findFreeTimeSlots(times: [Double]) -> [(Double, Double)] {
        
        var freeTimeSlots: [(Double, Double)] = []
        let takenTimeSlots = findTakenTimeSlots(times: times)
        let startEnd = getWeekStartAndEndTime()
        let oneDay: Double = 24 * 60 * 60
        
        if takenTimeSlots.count > 1 {
            for i in 0...(takenTimeSlots.count - 2) {
                
                freeTimeSlots += createTimeIntervals(freeTimeSlot: (takenTimeSlots[i].1, takenTimeSlots[i + 1].0))
                
            }
            
            freeTimeSlots += createTimeIntervals(freeTimeSlot: (startEnd.0, takenTimeSlots[0].0))
            freeTimeSlots += createTimeIntervals(freeTimeSlot: (takenTimeSlots[takenTimeSlots.count - 1].1, startEnd.1))
            
        } else if takenTimeSlots.count == 1 {
            freeTimeSlots += createTimeIntervals(freeTimeSlot: (startEnd.0, takenTimeSlots[0].0))
            freeTimeSlots += createTimeIntervals(freeTimeSlot: (takenTimeSlots[0].1, startEnd.1))
            
        } else {
            freeTimeSlots += createTimeIntervals(freeTimeSlot: startEnd)
        }
        
        freeTimeSlots.sort{ $0.0 < $1.0 }
        
        return freeTimeSlots
    }
    
    func createFreeTimeSlotEvents() {
        
        let freeTimeSlots = findFreeTimeSlots(times: convertDataToDouble())
        var newEvents: [IdentifiableEvent] = []
        var numEvents = 1
        
        for time in freeTimeSlots {
            
            let newEvent = EKEvent(eventStore: CalendarViewModel.shared.store)
            
            newEvent.startDate = Date(timeIntervalSince1970: time.0)
            newEvent.endDate = Date(timeIntervalSince1970: time.1)
            newEvent.timeZone = TimeZone(identifier: "America/Los_Angeles")
            newEvent.title = "Free Time Slot \(numEvents)"
            
            numEvents += 1
            
            newEvents.append(IdentifiableEvent(event: newEvent))
        }
        
        DispatchQueue.main.async{
            CalendarViewModel.shared.eventsToDisplay = newEvents
        }
        
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
