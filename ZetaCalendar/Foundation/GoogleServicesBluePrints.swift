//
//  GoogleServicesBluePrints.swift
//  ZetaCalendar
//
//  Created by Bhanu Sharma on 10/06/24.
//


import Foundation
import GoogleAPIClientForREST
import GoogleSignIn

protocol GoogleServiceRepository {
}

protocol GoogleCalanderAPIRepository: GoogleServiceRepository {
    func fetchCalendarEvents(date: Date, completion: @escaping ([GTLRCalendar_Event]) -> Void)
    func addEvent(summary: String, description: String, startDate: Date, endDate: Date, completion: @escaping (GTLRCalendar_Event?) -> Void)
}

//protocol GoogleDriveAPIRepository: GoogleServiceRepository {
//
//} etc...
