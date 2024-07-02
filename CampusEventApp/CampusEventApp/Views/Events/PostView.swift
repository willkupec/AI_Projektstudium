import SwiftUI

struct PostView: View {
    let post: Post
    @State private var newCommentContent: String = ""
    @State private var comments: [PostComment] = []
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .top) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                                .padding(.trailing, 5)
                            
                            VStack(alignment: .leading) {
                                HStack(alignment: .bottom) {
                                    Text(post.authorName)
                                        .font(.headline)
                                    
                                    Text(post.time, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .padding(.leading, 5)
                                }
                                .padding(.top, 3)
                            }
                        }
                        
                        Text(post.title)
                            .font(.title)
                            .bold()
                        
                        Text(post.content)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 1)
                        
                        
                        // TODO edit & delete; only when authorized user
                        HStack(spacing: 25) {
                            Image(systemName: "pencil")
                                .frame(width: 20, height: 20)
                            
                            Image(systemName: "trash")
                                .frame(width: 20, height: 20)
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(comments) { comment in
                            VStack(alignment: .leading, spacing: 10) {
                                HStack(alignment: .top) {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .clipShape(Circle())
                                        .padding(.trailing, 5)
                                    
                                    VStack(alignment: .leading) {
                                        Text(comment.author)
                                            .font(.subheadline)
                                            .bold()
                                        
                                        Text(comment.timestamp, style: .time)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.vertical, 5)
                                
                                Text(comment.content)
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.top, 10)
                    }
                    .padding(.top, 8)
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack {
                TextField("Add comment...", text: $newCommentContent)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                
                Button(action: addComment) {
                    Text("Post")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        /*
        .onAppear {
            self.comments = post.comments
        }*/
    }
    
    private func addComment() {
        let newComment = PostComment(id: UUID().uuidString, author: "Current User", timestamp: Date(), content: newCommentContent, post: post)
        comments.append(newComment)
        newCommentContent = ""
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePost = Post(id: "post-1", eventId: "1", authorId: "123", authorName: "Max Muster", title: "Anyone up for drinks?", content: "We are gathering at table 2 in the conference room. Come with us for some drinks!", time: Date(), isOnceEdited: false)
        
        NavigationView {
            PostView(post: samplePost)
        }
    }
}
