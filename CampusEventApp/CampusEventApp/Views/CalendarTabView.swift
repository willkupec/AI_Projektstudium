import SwiftUI
import EventKit

struct CalendarTabView: View {
    @Binding var eventStore: EKEventStore
    @Binding var calendarAccessGranted: Bool
    @Binding var events: [EKEvent]
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ImportCalendarView(eventStore: $eventStore, calendarAccessGranted: $calendarAccessGranted, events: $events)) {
                    Label("Import Calendar", systemImage: "square.and.arrow.down")
                }
                NavigationLink(destination: InAppCalendarView(events: $events)) {
                    Label("Calendar", systemImage: "calendar")
                }
            }
            .navigationTitle("Calendar")
        }
    }
}
