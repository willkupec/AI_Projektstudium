//
//  NewMessageScreen.swift
//  CampusEventApp


import SwiftUI
import Firebase
import Foundation

struct RecentMessage: Identifiable {
    
    let text, username: String
    let timestamp: Firebase.Timestamp
    let documentId: String
    let fromId, toId, profileImageURL: String
    
    var id: String { documentId}
    
    init(documentId: String, data: [String:Any]){
        self.documentId = documentId
        self.text = data["text"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.username = data["username"] as? String ?? ""
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.profileImageURL = data["profileImageURL"] as? String ?? ""
    }
}

class CreateNewMessageViewModel: ObservableObject {
    
    @Published var users = [ChatUser]()
    @Published var errorMessage = ""
    @Published var isUserCurrentlyLoggedOut = false
    
    @Published var recentMessages: [RecentMessage] = []
    @Published var filteredMessages: [RecentMessage] = []
    
    @Published var filteredUsers = [ChatUser]()
    
    init() {
        
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        
        fetchAllUsers()
        
        fetchRecentMessages()
    }
    
    func filterUsers(query: String) {
        if query.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter { $0.username.lowercased().contains(query.lowercased()) }
        }
    }
    
    func getUser(matching recentMessage: RecentMessage) -> ChatUser? {
            return users.first(where: { $0.username == recentMessage.username })
        }
    
    func filterMessages(query: String) {
        if query.isEmpty {
            filteredMessages = recentMessages
        } else {
            filteredMessages = recentMessages.filter { $0.username.lowercased().contains(query.lowercased()) || $0.text.lowercased().contains(query.lowercased()) }
        }
    }
    
    private func fetchRecentMessages() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        
        FirebaseManager.shared.firestore
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for recent messages \(error)"
                    print(error)
                    return
                }
                querySnapshot?.documentChanges.forEach({change in
                    
                    let docId = change.document.documentID
                    if let index = self.recentMessages.firstIndex(where: { rm in
                        return rm.documentId == docId
                    }) {
                        self.recentMessages.remove(at: index)
                    }
                    
                    self.recentMessages.insert(.init(documentId: docId, data: change.document.data()), at: 0) //puts new message at the front of the list
                    
                   // self.recentMessages.append(.init(documentId: docId, data: change.document.data()))
                    
                })
                self.filteredMessages = self.recentMessages
            }
    }
    
    private func fetchAllUsers() {
        FirebaseManager.shared.firestore.collection("users")
            .getDocuments { documentsSnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch users: \(error)"
                    print("Failed to fetch users: \(error)")
                    return
                }
                
                documentsSnapshot?.documents.forEach({snaphot in
                    let data = snaphot.data()
                    let user = ChatUser(data: data)
                    if user.uid != FirebaseManager.shared.auth.currentUser?.uid {
                        self.users.append(.init(data: data))
                    }
                })
                self.filteredUsers = self.users
            }
    }
}

struct NewMessageScreen: View {
    
    let didSelectNewUser: (ChatUser) -> ()
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var vm = CreateNewMessageViewModel()
    
    @State private var query = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search users", text: $query)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding([.leading, .trailing])
                    
                    Button(action: {
                        vm.filterUsers(query: query)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .padding([.trailing])
                    }
                }
                
                ScrollView {
                    ForEach(vm.filteredUsers) { user in
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            didSelectNewUser(user)
                        } label: {
                            HStack(spacing: 16) {
                                if let url = URL(string: user.profileImageURL) {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 50, height: 50)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50)
                                                .clipped()
                                                .cornerRadius(25)
                                                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color(.label), lineWidth: 2))
                                        case .failure:
                                            Image(systemName: "person.circle")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50)
                                                .clipped()
                                                .cornerRadius(25)
                                                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color(.label), lineWidth: 2))
                                                .foregroundColor(Color(.label))
                                        @unknown default:
                                            Image(systemName: "person.circle")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50)
                                                .clipped()
                                                .cornerRadius(25)
                                                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color(.label), lineWidth: 2))
                                                .foregroundColor(Color(.label))
                                        }
                                    }
                                } else {
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                        .cornerRadius(25)
                                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color(.label), lineWidth: 2))
                                        .foregroundColor(Color(.label))
                                }
                                Text(user.username)
                                    .foregroundColor(Color(.label))
                                Spacer()
                            }
                            .padding(.horizontal)
                            Divider()
                                .padding(.vertical, 8)
                        }
                    }
                }
                .navigationTitle("New Message")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
            }
        }
    }
}
