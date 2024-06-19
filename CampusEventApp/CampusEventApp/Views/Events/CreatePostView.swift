import SwiftUI

struct CreatePostView: View {
    let event: Event
    @State private var title: String = ""
    @State private var content: String = ""
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
                    //createPost()
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
    /*
    private func createPost() {
        guard !title.isEmpty, !content.isEmpty else { return }
        
        let newPost = Post(
            id: UUID().uuidString,
            event: event,
            author: "Current User",
            title: title,
            content: content,
            time: Date(),
            comments: []
        )
        
        //eventController.addPost(to: event, post: newPost)
        presentationMode.wrappedValue.dismiss()
    }*/
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView(
            event: Event(id: "1", name: "Sample Event 1", start: "10:00", end: "11:00", date: Date(), type: "Conference", description: "A sample conference event", organizer: "Organizer 1", location: "Location 1", photo: "", posts: []),
            eventController: EventController()
        )
    }
}
