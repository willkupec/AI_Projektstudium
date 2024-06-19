import SwiftUI

struct CreateEventView: View {
    @State private var name: String = ""
    @State private var start: Date = Date()
    @State private var end: Date = Date()
    @State private var date: Date = Date()
    @State private var type: String = "Lehrveranstaltung"
    @State private var description: String = ""
    @State private var organizer: String = ""
    @State private var location: String = ""
    //@State private var photo: UIImage? = nil
    @State private var photo: String = ""
    @State private var showImagePicker: Bool = false
    @State private var showTypePicker: Bool = false
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
                        
                        /*if let photo = photo {
                            Image(uiImage: photo)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                        }
                        Button(action: {
                            showImagePicker = true
                        }) {
                            Text(photo == nil ? "Upload Photo" : "Change Photo")
                                .foregroundColor(.blue)
                        }*/
                    }

                    Button(action: {
                        createEvent()
                    }) {
                        Text("Create Event")
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
            .navigationTitle("Create a HTW event")
            /*.sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $photo)
            }*/
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

    private func createEvent() {

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"

        let event = Event(
            id: UUID().uuidString,
            name: name,
            start: timeFormatter.string(from: start),
            end: timeFormatter.string(from: end),
            date: date,
            type: type,
            description: description,
            organizer: organizer,
            location: location,
            photo: photo,
            posts: []
        )
        
        eventController.createEvent(event: event)
            eventController.shouldReloadEvents = true
            presentationMode.wrappedValue.dismiss()

        /*
        eventController.createEventWithPhoto(event: event, photo: photo) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            } else {
            }
        }*/
        
        
    }
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView(eventController: EventController())
    }
}
