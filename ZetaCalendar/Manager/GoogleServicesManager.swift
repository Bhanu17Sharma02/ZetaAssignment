//
//  GoogleAPIManager.swift
//  ZetaCalendar
//
//  Created by Bhanu Sharma on 10/06/24.
//

import Foundation
import GoogleAPIClientForREST
import GoogleSignIn

class GoogleServicesManager {
    
    var calanaderService: GoogleCalanderAPIRepository?
    
    // we can also inject other service as well as per our requirement. Example: GoogleDriveAPIService
    init(service: GoogleCalanderAPIRepository = CalanderAPIService()) {
        self.calanaderService = service
    }
    
}

extension GoogleServicesManager {
    func fetchEvent(date: Date, completion: @escaping ([GTLRCalendar_Event]) -> Void){
        self.calanaderService?.fetchCalendarEvents(date: date,completion: completion)
    }
    
    func addEvent(summary: String, description: String, startDate: Date, endDate: Date, completion: @escaping (GTLRCalendar_Event?) -> Void) {
        self.calanaderService?.addEvent(summary: summary, description: description, startDate: startDate, endDate: endDate, completion: completion)
    }
}
