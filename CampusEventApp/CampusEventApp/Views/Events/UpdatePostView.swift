import SwiftUI
import FirebaseAuth

struct UpdatePostView: View {
    @State var post: Post
    var eventController: EventController
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String
    @State private var content: String
    
    init(post: Post, eventController: EventController) {
        self.post = post
        self.eventController = eventController
        _title = State(initialValue: post.title)
        _content = State(initialValue: post.content)
    }
    
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
                }
                
                VStack(alignment: .leading) {
                    Text("Content")
                        .font(.subheadline)
                    TextEditor(text: $content)
                        .padding()
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .frame(maxHeight: 200)
                }
                
                Button(action: {
                    updatePost()
                }) {
                    Text("Update Post")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Update Post")
        }
    }
    
    private func updatePost() {
        guard let currentUser = Auth.auth().currentUser, currentUser.uid == post.authorId else {
            print("Unauthorized user")
            return
        }
        
        let updatedContent: [String: Any] = [
            "title": title,
            "content": content,
            "isOnceEdited": true
        ]
        
        eventController.updatePost(eventID: post.eventId, postID: post.id, updatedContent: updatedContent) { success in
            DispatchQueue.main.async {
                if success {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    print("Failed to update post")
                }
            }
        }
    }
}

struct UpdatePostView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePostView(
            post: Post(id: "post1", eventId: "1", authorId: "456", authorName: "Max Muster", title: "Sample Title", content: "Sample content", time: Date(), isOnceEdited: false),
            eventController: EventController()
        )
    }
}
