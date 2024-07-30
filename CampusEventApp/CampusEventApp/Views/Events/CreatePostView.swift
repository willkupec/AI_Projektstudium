import SwiftUI
import FirebaseAuth

struct CreatePostView: View {
    let event: Event
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var titleError: String? = nil
    @State private var contentError: String? = nil
    var eventController: EventController
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(alignment: .leading) {
                    Text("Title")
                        .font(.subheadline)
                    TextField("Enter post title", text: $title)
                        .padding()
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    if let error = titleError {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Content")
                        .font(.subheadline)
                    TextEditor(text: $content)
                        .padding()
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .frame(maxHeight: 200)
                    if let error = contentError {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                Button(action: {
                    createPost()
                }) {
                    Text("Post")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.top)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Create Post")
        }
    }
    
    private func validateFields() -> Bool {
        var isValid = true
        if title.isEmpty {
            titleError = "Post title is required."
            isValid = false
        } else {
            titleError = nil
        }

        if content.isEmpty {
            contentError = "Post content is required."
            isValid = false
        } else {
            contentError = nil
        }

        return isValid
    }

    private func createPost() {
        guard let currentUser = Auth.auth().currentUser else {
            print("No user logged in")
            return
        }

        if !validateFields() {
            return
        }

        getUsername { username in
            let post = Post(
                id: UUID().uuidString,
                eventId: event.id,
                authorId: currentUser.uid,
                authorName: username,
                title: title,
                content: content,
                time: Date(),
                isOnceEdited: false
            )
            
            eventController.createPost(to: event, post: post)
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView(
            event: Event(id: "1", name: "Sample Event 1", start: "10:00", end: "11:00", date: Date(), type: "Conference", description: "A sample conference event", organizerId: "123", organizerName: "Organizer 1", location: "Location 1", photo: "", posts: []),
            eventController: EventController()
        )
    }
}
