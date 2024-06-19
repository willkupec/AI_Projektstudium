import Foundation

struct Event: Identifiable, Hashable {
    let id: String
    let name: String
    let start: String
    let end: String
    let date: Date
    let type: String
    let description: String
    let organizer: String
    let location: String
    let photo: String
    var posts: [Post]
}

struct Post: Identifiable, Hashable {
    let id: String
    let eventId: String
    let author: String
    let title: String
    let content: String
    let time: Date 
    //var comments: [PostComment]
}

struct PostComment: Identifiable, Hashable {
    let id: String
    let author: String
    let timestamp: Date
    let content: String
    let post: Post 
}
