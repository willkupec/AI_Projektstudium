import SwiftUI

struct EventDetailView: View {
    @State var event: Event
    @State private var showAlert = false
    @State private var posts: [Post] = []
    @Environment(\.presentationMode) var presentationMode
    var eventController: EventController
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var body: some View {
        VStack {
            ZStack {
                ScrollView {
                    VStack {
                        if let url = URL(string: event.photo), !event.photo.isEmpty {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .cornerRadius(10)
                                    .padding()
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .cornerRadius(10)
                                    .padding()
                            }
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                                .padding()
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("\(event.name)")
                                .font(.system(size: 50))
                            Text("\(event.description)")
                                .lineLimit(10)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.system(size: 20))
                            Text("\(event.type) von \(event.organizer)")
                                .padding(.top, 20)
                            Text("\(event.location)")
                            Text("\(event.start) - \(event.end) Uhr, \(dateFormatter.string(from: event.date))")
                            
                            NavigationLink(destination: UpdateEventView(event: event, eventController: eventController)) {
                                HStack {
                                    Image(systemName: "pencil")
                                        .frame(width: 30, height: 30)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.top)
                        }
                        .padding()
                        
                        VStack(alignment: .leading) {
                            Text("All event posts")
                                .font(.system(size: 30))
                        }
                        .padding()
                        
                        ForEach(posts) { post in
                            NavigationLink(destination: PostView(post: post)) {
                                VStack(alignment: .leading) {
                                    HStack(alignment: .top) {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .clipShape(Circle())
                                            .foregroundStyle(Color.green)
                                            .padding(.trailing, 5)
                                        
                                            VStack(alignment: .leading) {
                                                Text("\(post.author)")
                                                    .font(.system(size: 20))
                                                    .foregroundStyle(.black)
                                                
                                                Text(post.time, style: .date)
                                                    .foregroundStyle(.gray)
                                                    .font(.system(size: 13))
                                            }
                                    }
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(post.title)
                                            .font(.system(size: 22))
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text(post.content)
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.black)
                                    }
                                    .padding(.bottom, 20)
                                    
                                    Divider()
                                    HStack {
                                        Text("Add comment...")
                                            .foregroundColor(.gray)
                                    }
                                    .padding([.leading, .trailing], 10)
                                }
                                .padding()
                                .background(Color.white.opacity(0.5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            }
                            .frame(maxWidth: 400, alignment: .leading)
                            .padding(.horizontal)
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: CreatePostView(event: event, eventController: eventController)) {
                            Image(systemName: "square.and.pencil")
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
        .onAppear {
            reloadEvent(event.id)
        }
    }
    
    private func fetchEventPosts() {
        eventController.fetchEventPosts(eventID: event.id) { posts in
            self.posts = posts
        }
    }
    
    private func reloadEvent(_ eventId: String) {
        eventController.fetchEventDetails(eventID: eventId) { fetchedEvent in
            if let fetchedEvent = fetchedEvent {
                self.event = fetchedEvent
                fetchEventPosts()
            }
        }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EventDetailView(event: Event(id: "1", name: "Sample Event 1", start: "10:00", end: "11:00", date: Date(), type: "Conference", description: "A sample conference event", organizer: "Organizer 1", location: "Location 1", photo: "", posts: [
                Post(id: "post1", eventId: "1", author: "Max Muster", title: "Anyone up for drinks at table 2?", content: "We are gathering at table 2 in the conference room. Anyone wants to join in? We'll get some drinks.", time: Date())
            ]), eventController: EventController())
        }
    }
}
