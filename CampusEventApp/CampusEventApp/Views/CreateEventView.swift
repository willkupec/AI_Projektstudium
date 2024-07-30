import SwiftUI
import FirebaseAuth

struct CreateEventView: View {
    @State private var name: String = ""
    @State private var start: Date = Date()
    @State private var end: Date = Date()
    @State private var date: Date = Date()
    @State private var type: String = "Lehrveranstaltung"
    @State private var description: String = ""
    @State private var location: String = ""
    @State private var photo: String = ""
    @State private var showImagePicker: Bool = false
    @State private var showTypePicker: Bool = false
    @State private var errorMessage: String? = nil
    
    @State private var nameError: String? = nil
    @State private var typeError: String? = nil
    @State private var descriptionError: String? = nil
    @State private var locationError: String? = nil
    
    var eventController: EventController
    @Environment(\.presentationMode) var presentationMode

    let eventTypes = ["Lehrveranstaltung", "Club event", "Meetup", "Workshop", "Andere"]

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
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            if let error = nameError {
                                Text(error)
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
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
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            }
                            if let error = typeError {
                                Text(error)
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                        }

                        VStack(alignment: .leading) {
                            Text("Description")
                                .font(.headline)
                            TextEditor(text: $description)
                                .padding()
                                .frame(minHeight: 100)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            if let error = descriptionError {
                                Text(error)
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                        }

                        VStack(alignment: .leading) {
                            Text("Location")
                                .font(.headline)
                            TextField("Enter event location", text: $location)
                                .padding()
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            if let error = locationError {
                                Text(error)
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
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
                        
                        TextField("Enter photo URL", text: $photo)
                            .padding()
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    }

                    Button(action: {
                        do {
                            try createEvent()
                            errorMessage = nil 
                        } catch {
                            errorMessage = error.localizedDescription
                        }
                    }) {
                        Text("Create Event")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                    }

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.top, 10)
                    }
                }
                .padding()
            }
            .background(Color.white)
            .navigationTitle("Create a HTW event")
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

    private func validateFields() -> Bool {
        var isValid = true
        if name.isEmpty {
            nameError = "Event name is required."
            isValid = false
        } else {
            nameError = nil
        }

        if type.isEmpty {
            typeError = "Event type is required."
            isValid = false
        } else {
            typeError = nil
        }

        if description.isEmpty {
            descriptionError = "Event description is required."
            isValid = false
        } else {
            descriptionError = nil
        }

        if location.isEmpty {
            locationError = "Event location is required."
            isValid = false
        } else {
            locationError = nil
        }

        return isValid
    }

    private func createEvent() throws {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        guard let uid = Auth.auth().currentUser?.uid else {
            throw EventCreationError.missingUserInfo
        }
        
        if !validateFields() {
            return
        }
        
        getUsername { username in
            let event = Event(
                id: UUID().uuidString,
                name: name,
                start: timeFormatter.string(from: start),
                end: timeFormatter.string(from: end),
                date: date,
                type: type,
                description: description,
                organizerId: uid,
                organizerName: username,
                location: location,
                photo: photo,
                posts: []
            )
            
            eventController.createEvent(event: event)
            eventController.shouldReloadEvents = true
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    enum EventCreationError: Error, LocalizedError {
        case missingUserInfo
        
        var errorDescription: String? {
            switch self {
            case .missingUserInfo:
                return NSLocalizedString("Organizer information is missing. Please log in again.", comment: "")
            }
        }
    }
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView(eventController: EventController())
    }
}
