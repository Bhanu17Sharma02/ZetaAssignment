//import SwiftUI
//import GoogleAPIClientForREST
//import GoogleSignIn
//import GoogleSignInSwift
//
//struct EventListView: View {
//    @State private var events: [GTLRCalendar_Event] = []
//    
//    var body: some View {
//        List(events, id: \.identifier) { event in
//            Text(event.summary ?? "No Title")
//        }
//        .onAppear {
//            fetchEvents { fetchedEvents in
//                if let fetchedEvents = fetchedEvents {
//                    self.events = fetchedEvents
//                }
//            }
//        }
//    }
//    
//    func fetchEvents(completion: @escaping ([GTLRCalendar_Event]?) -> Void) {
//        guard let user = GIDSignIn.sharedInstance.currentUser else {
//            completion(nil)
//            return
//        }
//        
//        let calendarService = GTLRCalendarService()
//        calendarService.authorizer = user.fetcherAuthorizer
//        
//        let query = GTLRCalendarQuery_EventsList.query(withCalendarId: "primary")
//        calendarService.executeQuery(query) { (ticket, events, error) in
//            if let error = error {
//                print("Error fetching events: \(error)")
//                completion(nil)
//            } else {
//                completion((events as? [GTLRCalendar_Event]))
//            }
//        }
//    }
//}
