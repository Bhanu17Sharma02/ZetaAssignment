//
//  CalanaderViewModel.swift
//  ZetaCalendar
//
//  Created by Bhanu Sharma on 10/06/24.
//

import Foundation
import GoogleSignIn
import GoogleAPIClientForREST

class CalanaderViewModel: ObservableObject {
    
    @Published var events: [GTLRCalendar_Event] = []
    var manager = GoogleServicesManager(service: CalanderAPIService())
    
    /**
       NOTE:  By default it takes today's date to fetch events from Calendar Api.
     */
    func fetchCalendarEvents(date: Date = Date()) {
        self.manager.fetchEvent(date: date) { events in
            self.events = events
        }
    }
    
    func addEvent(summary: String, description: String, startDate: Date, endDate: Date, completion: @escaping (GTLRCalendar_Event?) -> Void) {
        
        self.manager.addEvent(summary: summary, description: description, startDate: startDate, endDate: endDate,completion: completion) 
    }
}
