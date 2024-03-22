import Foundation
import EventKit

struct IdentifiableEvent: Identifiable {
    let id = UUID()
    let event: EKEvent
    let timeSlot: String
    
}

@MainActor class CalendarViewModel: ObservableObject {
    //only used in EventListView
    @Published var eventsToDisplay: [IdentifiableEvent] = []
    @Published var currentDay: Date = Date()
    @Published var isBusinessHours = true
    
    static let shared = CalendarViewModel()
    let store: EKEventStore
    
    var events: [IdentifiableEvent] = []
    var allFreeEvents: [IdentifiableEvent] = []
    var currentWeek: [Date] = []
    var currentMonth: String = ""
    var freeTimeCounter: Int
    
    var noEarlierThan: Double = 9
    var noLaterThan: Double = 17
    var intervalInMinutes: Double = 1 * 60
    
    init() {
        self.store = EKEventStore()
        self.events = []
        self.allFreeEvents = []
        self.currentWeek = []
        self.currentDay = Date()
        self.freeTimeCounter = 0
        fetchCurrentWeek()
        currentMonth = self.extractDate(date: currentDay, format: "MMMM")
    }
    
    func requestAccess() async {
        do {
            
            try await CalendarViewModel.shared.store.requestFullAccessToEvents()
            
        } catch {
            print(CalendarError.requestDataError)
        }
        
    }
    
    func fetchEvents(interval: Calendar.Component, startDate: Date, calendars: [EKCalendar]?) {
        
        guard let interval = Calendar.current.dateInterval(of: interval, for: startDate)
        else { print(CalendarError.calendarIntervalGenerationError); return }
        
        let predicate = CalendarViewModel.shared.store.predicateForEvents(withStart: interval.start, end: interval.end, calendars: calendars)
        
        let fetchedEvents = CalendarViewModel.shared.store.events(matching: predicate).sorted(by: {$0.startDate < $1.startDate})
        
        let nonAllDayEvents = fetchedEvents.filter { !$0.isAllDay }
        
        CalendarViewModel.shared.events = nonAllDayEvents.map{ IdentifiableEvent(event: $0, timeSlot: "") }
        
        createFreeTimeSlotEvents(startEndTimes: convertDataToDouble())
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
    
    func convertFreeTimesToDouble() -> [Double]{
        var unixTimeEvents: [Double] = []
        
        for currEvent in CalendarViewModel.shared.eventsToDisplay {
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
    
    func timeSlotContainsMidnight(timeSlot: (Double, Double)) -> ((Double, Double), (Double, Double)) {
        let oneDay: Double = 24 * 60 * 60
        let startEnd = getWeekStartAndEndTime()
        let midNight = [startEnd.0 + oneDay, startEnd.0 + 2 * oneDay,
                        startEnd.0 + 3 * oneDay, startEnd.0 + 4 * oneDay,
                        startEnd.0 + 5 * oneDay, startEnd.0 + 6 * oneDay,
                        startEnd.0 + 7 * oneDay]
        
        var newTimeSlots: [(Double, Double)] = []
        
        for time in midNight {
            if time < timeSlot.1 && time > timeSlot.0 {
                newTimeSlots.append((timeSlot.0, time - 1))
                newTimeSlots.append((time, timeSlot.1))
                
                return ((timeSlot.0, time - 1), (time, timeSlot.1))
            }
        }
        
        return ((0,0),(0,0))
    }
    
    func createTimeIntervals(freeTimeSlot: (Double, Double)) -> [(Double, Double)] {
        var timeIntervals: [(Double, Double)] = []
        let secondsInterval = self.intervalInMinutes * 60
        let totalTimeIntervals = (freeTimeSlot.1 - freeTimeSlot.0) / secondsInterval
        
        var nextInterval = freeTimeSlot.0
        
        if (totalTimeIntervals > 0){
            for _ in 1...Int(ceil(totalTimeIntervals)) {
                
                if nextInterval + secondsInterval <= freeTimeSlot.1 {
                    let midNightIntervals = timeSlotContainsMidnight(timeSlot: (nextInterval, nextInterval + secondsInterval))
                    
                    if midNightIntervals.0.0 == 0 {
                        timeIntervals.append((nextInterval, nextInterval + secondsInterval - 1))
                        nextInterval += secondsInterval
                    } else {
                        timeIntervals += [midNightIntervals.0]
                        nextInterval = midNightIntervals.1.0
                    }
                    
                } else {
                    let midNightIntervals = timeSlotContainsMidnight(timeSlot: (nextInterval, freeTimeSlot.1))

                    if midNightIntervals.0.0 == 0 {
                        timeIntervals.append((nextInterval, freeTimeSlot.1))
                    } else {
                        timeIntervals += [midNightIntervals.0, midNightIntervals.1]
                    }
                }
            }
        }

        return timeIntervals
    }
    
    func findFreeTimeSlots(times: [Double]) -> [(Double, Double)] {
        
        var freeTimeSlots: [(Double, Double)] = []
        let takenTimeSlots = findTakenTimeSlots(times: times)
        let startEnd = getWeekStartAndEndTime()
        
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
    
    func createFreeTimeSlotEvents(startEndTimes: [Double]) {
        
        let freeTimeSlots = findFreeTimeSlots(times: startEndTimes)
        var newEvents: [IdentifiableEvent] = []
        var numEvents = 1
        
        for time in freeTimeSlots {
            
            let newEvent = EKEvent(eventStore: CalendarViewModel.shared.store)
            
            newEvent.startDate = Date(timeIntervalSince1970: time.0)
            newEvent.endDate = Date(timeIntervalSince1970: time.1)
            newEvent.timeZone = TimeZone(identifier: "America/Los_Angeles")
            newEvent.title = "Free Time Slot \(numEvents)"
            
            numEvents += 1
            
            var printableTime = ""
            
            printableTime += formatDate(newEvent.startDate, format: "EEE")
            printableTime += " "
            //add start time
            printableTime += formatDate(newEvent.startDate)
            printableTime += " - "
            //add end time
            printableTime += formatDate(newEvent.endDate)
            
            newEvents.append(IdentifiableEvent(event: newEvent, timeSlot: printableTime))
        }
        
        DispatchQueue.main.async{
            CalendarViewModel.shared.eventsToDisplay = newEvents
        }
        
        CalendarViewModel.shared.allFreeEvents = newEvents
        
        CalendarViewModel.shared.freeTimeCounter = 0
    }

    func hasFullAccess() -> Bool {
        let authStatus = EKEventStore.authorizationStatus(for: EKEntityType.event)

        if authStatus == .fullAccess {
          return true
        } else {
          return false
        }
    }
    
    func fetchCurrentWeek() {
            let today = Date()
            let calendar = Calendar.current
            
            let week = calendar.dateInterval(of:.weekOfMonth, for: today)
            
            guard let firstWeekDay = week?.start else {
                return
            }
            
            (0...6).forEach { day in
                if let weekday = calendar.date(byAdding:.day, value: day, to: firstWeekDay) {
                    currentWeek.append(weekday)
                }
                
            }
    }
    
    func extractDate(date: Date, format: String) -> String {
            let formatter = DateFormatter()
            
            formatter.dateFormat = format
            return formatter.string(from: date)
    }
    
    //check if the current day is today
    func verifyIsToday(date: Date) -> Bool {
            let calendar = Calendar.current
            return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    func getEventNames() -> [String] {
            //returns a string array of event names
            var res: [String] = []
            for ev in self.events {
                res.append(ev.event.title ?? "")
            }
            return res
    }
    
    func filterFreeEvents() -> [IdentifiableEvent] {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        let curDayNum = Calendar.current.component(.weekday, from: CalendarViewModel.shared.currentDay)
        
        let filteredEvents = self.allFreeEvents.filter { ev in
            let eva = ev.event
            let weekday = calendar.component(.weekday, from: eva.startDate)
            let hourStart = calendar.component(.hour, from: eva.startDate)
            let hourEnd = calendar.component(.hour, from: eva.endDate)
            
            return weekday == curDayNum && 
                hourStart >= Int(self.noEarlierThan) &&
                hourStart < Int(self.noLaterThan) &&
                hourEnd <= Int(self.noLaterThan)
        }
        
        return filteredEvents
    }
    
    func getNextFreeTime() -> String {
        
        let freeTime: String = "No free times found :("
        
        if CalendarViewModel.shared.allFreeEvents.count == 0 {
            return freeTime
        }
                
        //allows for cycling through the freetime events
        if CalendarViewModel.shared.freeTimeCounter + 1 >= CalendarViewModel.shared.allFreeEvents.count {
            
            CalendarViewModel.shared.freeTimeCounter = 0
            
        }else {
            
            CalendarViewModel.shared.freeTimeCounter += 1
            
        }
        
        return CalendarViewModel.shared.allFreeEvents[CalendarViewModel.shared.freeTimeCounter].timeSlot
    }
    
    private func formatDate(_ date: Date, format: String = "h:mm a") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
        
}
