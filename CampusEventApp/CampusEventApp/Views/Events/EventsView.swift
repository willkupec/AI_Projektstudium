import SwiftUI

struct EventsView: View {
    @State private var events: [Event] = []
    @State private var searchText = ""
    private let eventController = EventController()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    init(events: [Event] = []) {
        _events = State(initialValue: events)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(searchResults) { event in
                        NavigationLink(destination: EventDetailView(event: event, eventController: eventController)) {
                            VStack {
                                if let url = URL(string: event.photo), !event.photo.isEmpty {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 100)
                                            .clipped()
                                    } placeholder: {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 100)
                                            .frame(maxWidth: .infinity)
                                    }
                                    .frame(maxWidth: .infinity)
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 100)
                                        .frame(maxWidth: .infinity)
                                }
                                
                                
                                VStack {
                                    HStack {
                                        Text(event.name)
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    VStack {
                                        Text("\(event.organizer)")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.system(size: 12))
                                            .padding(.top, 1)
                                        
                                        
                                        Text("\(event.start) - \(event.end)")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.system(size: 12))
                                            .padding(.top, 8)
                                            
                                        
                                        Text(dateFormatter.string(from: event.date))
                                            .padding(.top, 2)
                                            .font(.system(size: 12))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .frame(alignment: .leading)
                            }
                            .cornerRadius(10)
                            .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 0.5))
                            .listRowSeparator(.hidden)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .onDelete(perform: deleteEvent)
                }
                .listStyle(.plain)
                .frame(alignment: .center)
                .navigationTitle("Events")
                .onAppear {
                    if eventController.shouldReloadEvents {
                        reloadEvents()
                        eventController.shouldReloadEvents = false
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: CreateEventView(eventController: eventController)) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
    
    var searchResults: [Event] {
        if searchText.isEmpty {
            return events
        } else {
            return events.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    private func reloadEvents() {
        eventController.fetchEvents { fetchedEvents in
            self.events = fetchedEvents
        }
    }
    
    private func deleteEvent(at offsets: IndexSet) {
        for index in offsets {
            let event = events[index]
            eventController.deleteEvent(eventID: event.id)
            events.remove(at: index)
        }
        eventController.shouldReloadEvents = true
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(events: [
            Event(id: "1", name: "Sample Event 1", start: "10:00 AM", end: "11:00 AM", date: Date(), type: "Conference", description: "A sample conference event", organizer: "Organizer 1", location: "Location 1", photo: "", posts: []),
             Event(id: "2", name: "Sample Event 2", start: "11:00 AM", end: "12:00 PM", date: Date(), type: "Workshop", description: "A sample workshop event", organizer: "Organizer 2", location: "Location 2", photo: "", posts: []),
             Event(id: "3", name: "Sample Event 3", start: "12:00 PM", end: "1:00 PM", date: Date(), type: "Meetup", description: "A sample meetup event", organizer: "Organizer 3", location: "Location 3", photo: "", posts: [])
         ])
    }
}
