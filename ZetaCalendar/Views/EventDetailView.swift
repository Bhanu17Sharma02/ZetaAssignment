//
//  EventDetailView.swift
//  ZetaCalendar
//
//  Created by Bhanu Sharma on 09/06/24.
//
import SwiftUI
import GoogleAPIClientForREST
import GoogleSignInSwift

struct EventDetailView: View {
    var event: GTLRCalendar_Event
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(event.summary ?? "No Title")
                    .font(.title)
                Text(event.descriptionProperty ?? "No Description")
                Text("Starts: \(event.start?.dateTime?.date ?? Date(), formatter: dateFormatter())")
                Text("Ends: \(event.end?.dateTime?.date ?? Date(), formatter: dateFormatter())")
            }
            .padding()
            .navigationTitle("Event Details")
        }
    }
    
    private func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()

        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
}


#Preview {
    EventDetailView(event: GTLRCalendar_Event())
}
