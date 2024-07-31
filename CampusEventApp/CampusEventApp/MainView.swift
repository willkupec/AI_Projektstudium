import SwiftUI
import EventKit

struct MainView: View {
    
    @Binding var isLoggedIn: Bool
    @State private var events: [EKEvent] = []
    @State private var eventStore = EKEventStore()
    @State private var calendarAccessGranted = false
    
    var body: some View {
        NavigationView {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                CalendarTabView(eventStore: $eventStore, calendarAccessGranted: $calendarAccessGranted, events: $events)
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }
                
                ChatView()
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("Chats")
                    }
                
                EventsView()
                    .tabItem {
                        Image(systemName: "network")
                        Text("Events")
                    }
                
                AccountView(isLoggedIn: $isLoggedIn)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("My Account")
                    }
            }
            .accentColor(.green)
            .onAppear {
                requestAccessToCalendar()
            }
        }
    }
    
    func requestAccessToCalendar() {
        eventStore.requestAccess(to: .event) { granted, error in
            DispatchQueue.main.async {
                self.calendarAccessGranted = granted
                if granted {
                    fetchEvents()
                } else {
                    print("Calendar access not granted")
                }
            }
        }
    }
    
    func fetchEvents() {
        let oneYearAgo = Date().addingTimeInterval(-365*24*60*60)
        let oneYearAfter = Date().addingTimeInterval(365*24*60*60)
        let predicate = eventStore.predicateForEvents(withStart: oneYearAgo, end: oneYearAfter, calendars: nil)
        
        DispatchQueue.main.async {
            self.events = eventStore.events(matching: predicate)
            print("Fetched \(self.events.count) events")
        }
    }
}
