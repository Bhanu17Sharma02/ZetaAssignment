import SwiftUI
import GoogleSignIn
import GoogleAPIClientForREST

struct MainCalendarView: View {
    @State private var selectedDate = Date()
    @State private var isPresent = false
    @State private var events: [GTLRCalendar_Event] = []
    @StateObject var viewModel = CalanaderViewModel()
    var body: some View {
        // NavigationView {
        VStack {
            CalendarView(date: self.$selectedDate)
            
            Divider()
            
            Text("Events of the day")
                .font(.headline)
            
            Divider()
            
            
            List(viewModel.events, id: \.self) { event in
                NavigationLink(destination: EventDetailView(event: event)) {
                    Text(event.summary ?? "No Title")
                }
            }
            .listStyle(.plain)
        }
        .navigationDestination(isPresented: $isPresent) {
            AddEventView(viewModel: viewModel)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Calendar")
        .onChange(of: self.selectedDate, { oldValue, newValue in
            viewModel.fetchCalendarEvents(date: newValue)
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("+ Add Event") {
                    self.isPresent = true
                }
            }
        }
        .onAppear {
            self.viewModel.fetchCalendarEvents()
        }
        .onDisappear{
            self.selectedDate = .now
        }
    }
    
//    /**
//       NOTE:  By default it takes today's date to fetch events from Calendar Api.
//     */
//    func fetchCalendarEvents(date: Date = Date()) {
//        guard let user = GIDSignIn.sharedInstance.currentUser else { return }
//        
//        let service = GTLRCalendarService()
//        service.authorizer = user.fetcherAuthorizer
//        
//        let calendar = Calendar.current
//            let now = date
//            let startOfDay = calendar.startOfDay(for: now)
//            var components = DateComponents()
//            components.day = 1
//            let endOfDay = calendar.date(byAdding: components, to: startOfDay)
//        
//        /**
//           -  Query is used to fetch event from calendar from Google calendar API
//           -  MaxResult : Batch of Event
//           - TimeMin or TimeMax: timpestamp of schedule events
//         */
//        let query = GTLRCalendarQuery_EventsList.query(withCalendarId: "primary")
//        query.maxResults = 10
//        query.timeMin = GTLRDateTime(date: startOfDay)
//        query.timeMax = GTLRDateTime(date: endOfDay!)
//        query.orderBy = kGTLRCalendarOrderByStartTime
//        query.singleEvents = true
//        
//        service.executeQuery(query) { (ticket, events, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            
//            
//            self.events = ((events as? GTLRCalendar_Events)?.items)!
//            
//            if let events = events as? GTLRCalendar_Events {
//                for event in events.items ?? [] {
//                    print(event.summary ?? "No title")
//                }
//            }
//        }
//    }
}



