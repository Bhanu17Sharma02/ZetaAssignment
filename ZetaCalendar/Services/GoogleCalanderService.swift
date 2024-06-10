//
//  GoogleServices.swift
//  ZetaCalendar
//
//  Created by Bhanu Sharma on 10/06/24.
//

import Foundation
import GoogleAPIClientForREST
import GoogleSignIn

class CalanderAPIService {
}

// I am using extension because of static dispatch.
extension CalanderAPIService: GoogleCalanderAPIRepository {
    
    func fetchCalendarEvents(date: Date = Date(),completion: @escaping ([GTLRCalendar_Event]) -> Void) {
            guard let user = GIDSignIn.sharedInstance.currentUser else { return }
            
            let service = GTLRCalendarService()
            service.authorizer = user.fetcherAuthorizer
            
            let calendar = Calendar.current
                let now = date
                let startOfDay = calendar.startOfDay(for: now)
                var components = DateComponents()
                components.day = 1
                let endOfDay = calendar.date(byAdding: components, to: startOfDay)
            
            /**
               -  Query is used to fetch event from calendar from Google calendar API
               -  MaxResult : Batch of Event
               - TimeMin or TimeMax: timpestamp of schedule events
             */
            let query = GTLRCalendarQuery_EventsList.query(withCalendarId: "primary")
            query.maxResults = 10
            query.timeMin = GTLRDateTime(date: startOfDay)
            query.timeMax = GTLRDateTime(date: endOfDay!)
            query.orderBy = kGTLRCalendarOrderByStartTime
            query.singleEvents = true
            
            service.executeQuery(query) { (ticket, events, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let events = events as? GTLRCalendar_Events {
                    completion(((events as? GTLRCalendar_Events)?.items)!)
                } else {
                    completion([])
                }
               // self.events = ((events as? GTLRCalendar_Events)?.items)!
//                
//                if let events = events as? GTLRCalendar_Events {
//                    for event in events.items ?? [] {
//                        print(event.summary ?? "No title")
//                    }
//                }
            }
    }
    
    func addEvent(summary: String, description: String, startDate: Date, endDate: Date, completion: @escaping (GTLRCalendar_Event?) -> Void) {
        guard let user = GIDSignIn.sharedInstance.currentUser else {
            completion(nil)
            return
        }
        
        let calendarService = GTLRCalendarService()
        calendarService.authorizer = user.fetcherAuthorizer
        
        let event = GTLRCalendar_Event()
        event.summary = summary
        event.descriptionProperty = description
        
        let start = GTLRCalendar_EventDateTime()
        start.dateTime = GTLRDateTime(date: startDate)
        event.start = start
        
        let end = GTLRCalendar_EventDateTime()
        end.dateTime = GTLRDateTime(date: endDate)
        event.end = end
        
        let query = GTLRCalendarQuery_EventsInsert.query(withObject: event, calendarId: "primary")
        calendarService.executeQuery(query) { (ticket, event, error) in
            if let error = error {
                print("Error adding event: \(error)")
                completion(nil)
            } else {
                completion(event as? GTLRCalendar_Event)
            }
        }
    }
}
