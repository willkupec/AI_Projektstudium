import SwiftUI
import UniformTypeIdentifiers
import EventKit

struct ImportCalendarView: View {
    @Binding var eventStore: EKEventStore
    @Binding var calendarAccessGranted: Bool
    @Binding var events: [EKEvent]

    @State private var showFilePicker = false
    @State private var showPermissionAlert = false
    @State private var showCalendarChoiceAlert = false
    @State private var showNewCalendarAlert = false
    @State private var newCalendarTitle = ""
    @State private var newCalendarColor = Color.blue
    @State private var eventsToAdd: [ICSEvent] = []
    @State private var selectedCalendar: EKCalendar?

    var body: some View {
        VStack {
            Image(systemName: "calendar")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Import .ics File to Calendar")
            Button(action: { showFilePicker = true }) {
                Text("Import .ics File")
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
        .alert(isPresented: $showPermissionAlert) {
            Alert(
                title: Text("Calendar Access Denied"),
                message: Text("Please enable calendar access in Settings to import events."),
                dismissButton: .default(Text("OK"))
            )
        }
        .fileImporter(isPresented: $showFilePicker, allowedContentTypes: [UTType(filenameExtension: "ics")!], allowsMultipleSelection: false, onCompletion: handleFilePickerResult)
        .alert(isPresented: $showCalendarChoiceAlert) {
            Alert(
                title: Text("Choose Calendar Option"),
                message: Text("Do you want to add events to an existing calendar or create a new one?"),
                primaryButton: .default(Text("Existing Calendar"), action: addEventsToExistingCalendar),
                secondaryButton: .default(Text("New Calendar")) {
                    self.showNewCalendarAlert = true
                }
            )
        }
        .textFieldAlert(isPresented: $showNewCalendarAlert, text: $newCalendarTitle, color: $newCalendarColor, onDone: createNewCalendar)
        .onAppear {
            // Ensure we request access to the calendar on appear
            requestCalendarAccess()
        }
    }

    // Request calendar access
    func requestCalendarAccess() {
        eventStore.requestAccess(to: .event) { granted, error in
            if granted {
                calendarAccessGranted = true
            } else {
                calendarAccessGranted = false
                showPermissionAlert = true
            }
        }
    }

    // Handle file picker result
    func handleFilePickerResult(result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            if let url = urls.first {
                print("File selected: \(url)")
                importICSFile(url: url)
            }
        case .failure(let error):
            print("Failed to pick file: \(error.localizedDescription)")
        }
    }

    // Import the .ics file and parse the events
    func importICSFile(url: URL) {
        do {
            let icsString = try String(contentsOf: url, encoding: .utf8)
            print("ICS file content read successfully")
            let events = ICSEventParser.parseICS(content: icsString)
            self.eventsToAdd = events
            print("Parsed events: \(events)")
            DispatchQueue.main.async {
                self.showCalendarChoiceAlert = true
            }
        } catch {
            print("Failed to read ICS file: \(error.localizedDescription)")
        }
    }

    // Create a new calendar
    func createNewCalendar() {
        let newCalendar = EKCalendar(for: .event, eventStore: eventStore)
        newCalendar.title = newCalendarTitle.isEmpty ? "New Calendar" : newCalendarTitle
        newCalendar.cgColor = UIColor(newCalendarColor).cgColor
        newCalendar.source = eventStore.defaultCalendarForNewEvents?.source

        do {
            try eventStore.saveCalendar(newCalendar, commit: true)
            print("New calendar created: \(newCalendar)")
            addEventsToCalendar(newCalendar)
            self.selectedCalendar = newCalendar
        } catch {
            print("Failed to create new calendar: \(error.localizedDescription)")
        }
    }

    // Add events to an existing calendar
    func addEventsToExistingCalendar() {
        guard let calendar = eventStore.defaultCalendarForNewEvents else {
            print("No default calendar found.")
            return
        }
        addEventsToCalendar(calendar)
        self.selectedCalendar = calendar
    }

    // Add events to the specified calendar
    func addEventsToCalendar(_ calendar: EKCalendar) {
        for event in eventsToAdd {
            let ekEvent = EKEvent(eventStore: eventStore)
            ekEvent.title = event.summary
            ekEvent.startDate = event.startDate
            ekEvent.endDate = event.endDate
            ekEvent.location = event.location
            ekEvent.calendar = calendar
            ekEvent.recurrenceRules = event.recurrenceRule != nil ? [event.recurrenceRule!] : nil

            print("Adding event: \(ekEvent.title ?? "") on \(String(describing: ekEvent.startDate))")

            do {
                try eventStore.save(ekEvent, span: .thisEvent, commit: true)
                print("Event added to calendar: \(ekEvent.title ?? "")")
            } catch {
                print("Failed to save event to calendar: \(error.localizedDescription)")
            }
        }
        fetchEvents()
    }

    // Fetch events from the selected calendar
    func fetchEvents() {
        guard let calendar = selectedCalendar else {
            print("No calendar selected.")
            return
        }

        let oneYearAgo = Date().addingTimeInterval(-365*24*60*60)
        let oneYearAfter = Date().addingTimeInterval(365*24*60*60)
        let predicate = eventStore.predicateForEvents(withStart: oneYearAgo, end: oneYearAfter, calendars: [calendar])

        DispatchQueue.main.async {
            self.events = eventStore.events(matching: predicate)
            print("Fetched events: \(self.events.count)") // Debug print statement to show number of events fetched
            for event in self.events {
                print("Event: \(event.title ?? "No Title") at \(String(describing: event.startDate))") // Print each fetched event's title and date
            }
        }
    }
}

extension View {
    func textFieldAlert(isPresented: Binding<Bool>, text: Binding<String>, color: Binding<Color>, onDone: @escaping () -> Void) -> some View {
        TextFieldAlert(isPresented: isPresented, text: text, color: color, onDone: onDone, presenting: self)
    }
}
