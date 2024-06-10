import SwiftUI
import GoogleAPIClientForREST
import GoogleSignIn

struct AddEventView: View {
    @State private var summary = ""
    @State private var description = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @ObservedObject var viewModel: CalanaderViewModel
    var body: some View {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Summary", text: $summary)
                    TextField("Description", text: $description)
                    DatePicker("Start Date", selection: $startDate)
                    DatePicker("End Date", selection: $endDate)
                }
                
                Button(action: {
                    viewModel.addEvent(summary: summary, description: description, startDate: startDate, endDate: endDate) { event in
                        if event != nil {
                            print("Event added")
                        }
                    }
                }) {
                    Text("Add Event")
                }
                
            }
        .navigationBarTitle("Add Event")
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
