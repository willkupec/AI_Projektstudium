import SwiftUI
import FirebaseAuth

struct EventDetailView: View {
    @State var event: Event
    @State private var showAlert = false
    @State private var posts: [Post] = []
    @State private var showQRCodeGenerator = false
    @Environment(\.presentationMode) var presentationMode
    var eventController: EventController

    var body: some View {
        VStack {
            ZStack {
                ScrollView {
                    VStack {
                        if let url = URL(string: event.photo), !event.photo.isEmpty {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(height: 200)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(10)
                                        .padding()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                        .cornerRadius(10)
                                        .padding()
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                        .cornerRadius(10)
                                        .padding()
                                @unknown default:
                                    EmptyView()
                                }
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
                                .multilineTextAlignment(.leading)
                            Text("\(event.description)")
                                .font(.system(size: 20))
                                .multilineTextAlignment(.leading)
                            Text("\(event.type) von \(event.organizerName)")
                                .padding(.top, 20)
                                .multilineTextAlignment(.leading)
                            Text("\(event.location)")
                                .multilineTextAlignment(.leading)
                            Text("\(event.start) - \(event.end) Uhr, \(event.date.formatDatum(event.date))")
                                .multilineTextAlignment(.leading)
                            
                            if event.organizerId == Auth.auth().currentUser?.uid {
                                NavigationLink(destination: UpdateEventView(event: event, eventController: eventController)) {
                                    HStack {
                                        Image(systemName: "pencil")
                                            .frame(width: 30, height: 30)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.top)
                                    .padding(.trailing, 5)
                                }
                            }
                        }
                        .padding(.horizontal, 25)
                        .frame(maxWidth: .infinity, alignment: .leading)

                        VStack(alignment: .leading) {
                            Text("All event posts")
                                .font(.system(size: 30))
                        }
                        .padding()

                        ForEach(posts) { post in
                            VStack(alignment: .leading) {
                                HStack(alignment: .top) {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .clipShape(Circle())
                                        .foregroundStyle(Color.green)
                                        .padding(.trailing, 5)

                                    VStack(alignment: .leading) {
                                        Text("\(post.authorName)")
                                            .font(.system(size: 20))
                                            .foregroundStyle(.black)

                                        Text(post.time, style: .time)
                                            .foregroundStyle(.gray)
                                            .font(.system(size: 13))
                                    }

                                    Spacer()

                                    if post.authorId == Auth.auth().currentUser?.uid {
                                        HStack {
                                            NavigationLink(destination: UpdatePostView(post: post, eventController: eventController)) {
                                                Image(systemName: "pencil")
                                                    .frame(width: 30, height: 30)
                                            }

                                            Button(action: {
                                                showAlert = true
                                            }) {
                                                Image(systemName: "trash")
                                                    .frame(width: 30, height: 30)
                                            }
                                            .alert(isPresented: $showAlert) {
                                                Alert(
                                                    title: Text("Confirm Delete"),
                                                    message: Text("Are you sure you want to delete this post?"),
                                                    primaryButton: .destructive(Text("Delete")) {
                                                        eventController.deletePost(eventID: event.id, postID: post.id) { success in
                                                            if success {
                                                                fetchEventPosts()
                                                            }
                                                        }
                                                    },
                                                    secondaryButton: .cancel()
                                                )
                                            }
                                        }
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
                                    
                                    if post.isOnceEdited {
                                        Text("edited")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                            .opacity(0.7)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
                                .padding(.bottom, 20)
                            }
                            .frame(maxWidth: 400, alignment: .leading)
                            .padding()
                            .background(Color.white.opacity(0.5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(5)
                .refreshable {
                    reloadEvent(event.id)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: CreatePostView(event: event, eventController: eventController)) {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                        Button(action: {
                            showQRCodeGenerator.toggle()
                        }) {
                            Image(systemName: "qrcode")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                        .sheet(isPresented: $showQRCodeGenerator) {
                            QRCodeView(event: event)
                        }
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
            EventDetailView(event: Event(id: "1", name: "Sample Event 1", start: "10:00", end: "11:00", date: Date(), type: "Conference", description: "A sample conference event", organizerId: "123", organizerName: "Organizer 1", location: "Location 1", photo: "", posts: [
                Post(id: "post1", eventId: "1", authorId: "456", authorName: "Max Muster", title: "Anyone up for drinks at table 2?", content: "We are gathering at table 2 in the conference room. Anyone wants to join in? We'll get some drinks.", time: Date(), isOnceEdited: true)
            ]), eventController: EventController())
        }
    }
}
