//
//  HomeView.swift
//  CampusEventApp
//
//  Created by Reinardus on 18.05.24.
//

import SwiftUI
import Firebase

import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    
    func load(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    deinit {
        cancellable?.cancel()
    }
}

struct URLImage: View {
    @StateObject private var loader = ImageLoader()
    let url: URL?
    let placeholder: Image

    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            }
        }
        .onAppear {
            if let url = url {
                loader.load(from: url)
            }
        }
    }
}

struct ChatView: View {
    
    @StateObject var viewModel = CreateNewMessageViewModel()
    
    @State private var query = ""
    
    @State var chatUser: ChatUser?
    
    @State var shouldShowNewMessageScreen: Bool = false
    
    @State var shouldNavigateToChatLogView: Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Chats")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: { shouldShowNewMessageScreen.toggle() }) {
                        Image(systemName: "square.and.pencil")
                            .font(.title)
                    }
                }
                .padding()
                
                HStack {
                    TextField("Search", text: $query)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding([.leading, .trailing])
                    
                    Button(action: {
                        viewModel.filterMessages(query: query)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .padding([.trailing])
                    }
                }
                
                List(viewModel.filteredMessages) { recentMessage in
                    VStack {
                        NavigationLink(destination: ChatLogView(chatUser: viewModel.getUser(matching: recentMessage))) {
                            HStack(spacing: 16) {
                                URLImage(url: URL(string: recentMessage.profileImageURL),
                                         placeholder: Image(systemName: "person.fill"))
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipped()
                                .cornerRadius(64)
                                .overlay(RoundedRectangle(cornerRadius: 64).stroke(Color.black, lineWidth: 2))
                                .shadow(radius: 5)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(recentMessage.username)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(Color(.label))
                                    Text(recentMessage.text)
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(.darkGray))
                                        .multilineTextAlignment(.leading)
                                }
                                
                                Spacer()
                                
                                Text(recentMessage.timestamp.dateValue().descriptiveString())
                                    .font(.system(size: 14, weight: .semibold))
                            }
                        }
                        Divider()
                    }
                }
                .listStyle(PlainListStyle())
                
                NavigationLink("", isActive: $shouldNavigateToChatLogView) {
                    if let chatUser = chatUser {
                        ChatLogView(chatUser: chatUser)
                    }
                }.hidden()
                
                .fullScreenCover(isPresented: $shouldShowNewMessageScreen) {
                    NewMessageScreen(didSelectNewUser: { user in
                        print(user.username)
                        self.shouldNavigateToChatLogView.toggle()
                        self.chatUser = user
                    })
                }
            }
        }
    }
            
            
        
    
        
        
        
        private var messagesView: some View {
            ScrollView {
                ForEach(viewModel.filteredMessages) { recentMessage in
                    VStack {
                        NavigationLink{
                            let navigationChatUser = viewModel.getUser(matching: recentMessage)
                            ChatLogView(chatUser: navigationChatUser)
                        }label: {
                            HStack(spacing: 16) {
                                
                                
                                URLImage(url: URL(string: recentMessage.profileImageURL),
                                         placeholder: Image(systemName: "person.fill"))
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipped()
                                .cornerRadius(64)
                                .overlay(RoundedRectangle(cornerRadius: 64).stroke(Color.black, lineWidth: 2))
                                .shadow(radius: 5)
                                
                            }
                            
                            VStack(alignment: .leading, spacing: 8){
                                Text(recentMessage.username)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(.label))
                                Text(recentMessage.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.darkGray))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            
                            Text(recentMessage.timestamp.dateValue().descriptiveString())
                                .font(.system(size: 14, weight: .semibold))
                        }
                        Divider()
                    }
                            
                }
            }
        }
    }








