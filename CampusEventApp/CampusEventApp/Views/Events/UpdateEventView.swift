import SwiftUI

struct UpdateEventView: View {
    @State private var name: String
    @State private var start: Date
    @State private var end: Date
    @State private var date: Date
    @State private var type: String
    @State private var description: String
    @State private var organizerId: String
    @State private var organizerName: String
    @State private var location: String
    //@State private var photo: UIImage? = nil
    @State private var photo: String = ""
    @State private var showImagePicker: Bool = false
    @State private var showTypePicker: Bool = false
    var event: Event
    var eventController: EventController
    @Environment(\.presentationMode) var presentationMode
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    let eventTypes = ["Lehrveranstaltung", "Club event", "Meetup", "Workshop", "Andere"]

    init(event: Event, eventController: EventController) {
        self.event = event
        self.eventController = eventController
        _name = State(initialValue: event.name)
        _start = State(initialValue: timeFormatter.date(from: event.start) ?? Date())
        _end = State(initialValue: timeFormatter.date(from: event.end) ?? Date())
        _date = State(initialValue: event.date)
        _type = State(initialValue: event.type)
        _photo = State(initialValue: event.photo)
        _description = State(initialValue: event.description)
        _organizerId = State(initialValue: event.organizerId)
        _organizerName = State(initialValue: event.organizerName)
        _location = State(initialValue: event.location)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.headline)
                            TextField("Enter event name", text: $name)
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        }

                        VStack(alignment: .leading) {
                            Text("Type")
                                .font(.headline)
                            Button(action: {
                                showTypePicker.toggle()
                            }) {
                                Text(type.isEmpty ? "Select event type" : type)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(type.isEmpty ? .gray : .black)
                                    .padding()
                                    .background(Color(UIColor.systemGray6))
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            }
                        }

                        VStack(alignment: .leading) {
                            Text("Description")
                                .font(.headline)
                            TextEditor(text: $description)
                                .background(Color(UIColor.systemGray6))
                                    .padding()
                                    .frame(minHeight: 100)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        }

                        VStack(alignment: .leading) {
                            Text("Location")
                                .font(.headline)
                            TextField("Enter event location", text: $location)
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        }
                    }

                    VStack(alignment: .leading) {
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                            .font(.system(size: 20))
                        DatePicker("Start Time", selection: $start, displayedComponents: .hourAndMinute)
                            .font(.system(size: 20))
                        DatePicker("End Time", selection: $end, displayedComponents: .hourAndMinute)
                            .font(.system(size: 20))
                    }

                    VStack(alignment: .leading) {
                        Text("Event Photo")
                            .font(.headline)
                        
                        TextField("Enter photo base64", text: $photo)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    }

                    Button(action: {
                        updateEvent()
                    }) {
                        Text("Update Event")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .background(Color.white)
            .navigationTitle("Update Event")
            .sheet(isPresented: $showTypePicker) {
                VStack {
                    Text("Select Event Type")
                        .font(.headline)
                        .padding()

                    Picker("Select event type", selection: $type) {
                        ForEach(eventTypes, id: \.self) { eventType in
                            Text(eventType).tag(eventType)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                    .padding()

                    Button(action: {
                        showTypePicker = false
                    }) {
                        Text("Done")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .presentationDetents([.medium, .large])
            }
        }
    }

    private func updateEvent() {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"

        let updatedEvent = Event(
            id: event.id,
            name: name,
            start: timeFormatter.string(from: start),
            end: timeFormatter.string(from: end),
            date: date,
            type: type,
            description: description,
            organizerId: organizerId,
            organizerName: organizerName,
            location: location,
            photo: photo,
            posts: event.posts
        )

        eventController.updateEvent(event: updatedEvent)
        eventController.shouldReloadEventDetail = true
        eventController.shouldReloadEvents = true
        presentationMode.wrappedValue.dismiss()
    }
}

struct UpdateEventView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateEventView(
            event: Event(id: "1", name: "Sample Event 1", start: "10:00", end: "11:00", date: Date(), type: "Conference", description: "A sample conference event", organizerId: "123", organizerName: "Organizer 1", location: "Location 1", photo: "", posts: []),
            eventController: EventController()
        )
    }
}
