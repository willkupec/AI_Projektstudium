//
//  ChatLogView.swift
//  CampusEventApp


import SwiftUI
import Firebase


struct FirebaseConstants {
    static let fromId = "fromId"
    static let toId = "toId"
    static let text = "text"
    static let timestamp = "timestamp"
    static let profileImageURL = "profileImageURL"
    static let username = "username"
}

struct ChatMessage: Identifiable {
    let fromId, toId, text: String
    let documentId: String
    
    var id: String { documentId }
    
    init(documentId: String, data: [String: Any]){
        self.documentId = documentId
        self.fromId = data[FirebaseConstants.fromId] as? String ?? ""
        self.toId = data[FirebaseConstants.toId] as? String ?? ""
        self.text = data[FirebaseConstants.text] as? String ?? ""
    }
}


class UserViewModel: ObservableObject {
    @Published var chatUser: ChatUser?

    init() {
        fetchCurrentUser()
    }

    func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Could not fetch uid")
            return
        }

        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch current user: ", error)
                return
            }

            guard let data = snapshot?.data() else {
                print("No data found")
                return
            }

            DispatchQueue.main.async {
                self.chatUser = ChatUser(data: data)
            }
        }
    }
}

class ChatLogViewModel: ObservableObject {
    
    @Published var chatText = ""
    @Published var errorMessage = ""
    
    @Published var chatMessages = [ChatMessage]()
    
    let chatUser: ChatUser?
    
    init(chatUser : ChatUser?){
        self.chatUser = chatUser
        
        fetchMessages()
    }
    
    private func fetchMessages() {
        
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid
        else { return }
        
        guard let toId = chatUser?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .order(by: FirebaseConstants.timestamp)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for messages: \(error)"
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        self.chatMessages.append(.init(documentId: change.document.documentID, data: data))
                    }
                })
                
                DispatchQueue.main.async{
                    self.count += 1
                }
        
            }
    }
    
    
    func handleSend(){
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid
        else { return }
        
        guard let toId = chatUser?.uid else { return }
        
        let document =
            FirebaseManager.shared.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
        
        let messageData = [FirebaseConstants.fromId: fromId, FirebaseConstants.toId: toId, FirebaseConstants.text: self.chatText, FirebaseConstants.timestamp: Timestamp()] as [String : Any]
        
        document.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }

            print("Successfully saved current user sending message")
            
            self.persistRecentMessage()
            
            self.chatText = ""
            self.count += 1
        }
        
        let recipientMessageDocument =
            FirebaseManager.shared.firestore
            .collection("messages")
            .document(toId)
            .collection(fromId)
            .document()
        
        recipientMessageDocument.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }
            print("Successfully saved current user sending message")
        }
        
    }
    
    private func persistRecentMessage() {
        guard let chatUser = chatUser else { return }
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let chatTextToSend = self.chatText
        
        // Daten für den aktuellen Benutzer speichern
        let document = FirebaseManager.shared.firestore
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .document(chatUser.uid)
        
        let data = [
            FirebaseConstants.timestamp: Timestamp(),
            FirebaseConstants.text: chatTextToSend,
            FirebaseConstants.fromId: uid,
            FirebaseConstants.toId: chatUser.uid,
            FirebaseConstants.profileImageURL: chatUser.profileImageURL,
            FirebaseConstants.username: chatUser.username
        ] as [String : Any]
        
        document.setData(data) { error in
            if let error = error {
                self.errorMessage = "Failed to save recent message: \(error)"
                return
            }
        }
        
        // Daten für den Empfänger speichern
        let recipientDocument = FirebaseManager.shared.firestore
            .collection("recent_messages")
            .document(chatUser.uid)
            .collection("messages")
            .document(uid)
        
        // Aktuellen Benutzer abrufen
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                return
            }
            
            guard let data = snapshot?.data(),
                  let profileImageURL = data[FirebaseConstants.profileImageURL] as? String,
                  let username = data[FirebaseConstants.username] as? String else {
                self.errorMessage = "Failed to fetch user data"
                return
            }
            
            let recipientData = [
                FirebaseConstants.timestamp: Timestamp(),
                FirebaseConstants.text: chatTextToSend,
                FirebaseConstants.fromId: uid,
                FirebaseConstants.toId: chatUser.uid,
                FirebaseConstants.profileImageURL: profileImageURL,
                FirebaseConstants.username: username
            ] as [String : Any]
            
            recipientDocument.setData(recipientData) { error in
                if let error = error {
                    self.errorMessage = "Failed to save recent message: \(error)"
                    return
                }
            }
        }
    }

    
    @Published var count = 0
}

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.vm = .init(chatUser: chatUser)
    }
    
    @ObservedObject var vm: ChatLogViewModel
    
    var body: some View {
        
        ZStack{
            chatMessagesView
            Text(vm.errorMessage)
        }
        
        .navigationTitle(chatUser?.username ?? "")
            .navigationBarTitleDisplayMode(.inline)
            

    }
    
    static let emptyScrollToString = "Empty"
    
    private var chatMessagesView: some View {
        ScrollView {
            ScrollViewReader{ scrollViewProxy in
                VStack{
                    ForEach(vm.chatMessages) { message in
                        MessageView(message: message)
                    }
                    HStack{ Spacer() }
                        .id(Self.emptyScrollToString)
                }
                .onReceive(vm.$count) { _ in
                    withAnimation(.easeOut(duration: 0.5)){
                        scrollViewProxy.scrollTo(Self.emptyScrollToString, anchor: .bottom)
                    }
                }
            }
            
        }
        .background(Color(.init(white: 0.95, alpha: 1)))
        .safeAreaInset(edge: .bottom) {
            chatBottomBar
                .background(Color(
                    .systemBackground)
                    .ignoresSafeArea())
        }
    }
    
    
    private var chatBottomBar: some View {
        HStack(spacing: 16){
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
            ZStack{
                
                TextEditor(text: $vm.chatText)
                    .opacity(vm.chatText.isEmpty ? 0.5 : 1)
                    
                //TextField("Description", text: $chatText)
            }
            .frame(height: 40)
            
            
            
            Button{
                vm.handleSend()
            }label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.green)
            .cornerRadius(4)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct MessageView: View {
    
    let message: ChatMessage
    
    var body: some View {
        VStack{
            if message.fromId == FirebaseManager.shared.auth.currentUser?.uid {
                HStack{
                    Spacer()
                    HStack {
                        Text(message.text)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
                }
                
            } else {
                HStack{
                    HStack {
                        Text(message.text)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}


