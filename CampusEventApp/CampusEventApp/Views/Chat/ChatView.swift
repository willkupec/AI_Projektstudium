//
//  HomeView.swift
//  CampusEventApp
//
//  Created by Reinardus on 18.05.24.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject var viewModel = ChatsViewModel()
    
    @State private var query = ""
    
    var body: some View {
        NavigationView {
            List {
                /*ForEach(0 ..< 10) {i in
                    ChatRow()
                }*/
                
                ForEach(viewModel.getSortedFilteredChats(query: query)) { chat in
                    
                    NavigationLink(destination: {     //Naviagtion link zum Chat
                        MessageView(chat: chat)
                            .environmentObject(viewModel)
                    }){
                        ChatRow(chat: chat)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) { //swipe to mark as Unread
                        Button(action: {
                            viewModel.markAsUnread(!chat.hasUnreadMessage, chat: chat)
                        }) {
                            if chat.hasUnreadMessage {
                                Label("Read", systemImage: "text.bubble")
                            } else {
                                Label("Unread", systemImage: "circle.fill")
                            }
                        }
                        .tint(.green)
                        
                    }
                    
                    /* Zum Verstecken des Link Buttons dem Pfeil
                     
                     ZStack {
                     
                        ChatRow(chat: chat)
                     
                        NavigationLink(destination: {
                            Text(chat.person.name)
                        }){
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 0)
                        .opacity(0)
                     }
                     
                     */
                    
                }
            }
            .listStyle(PlainListStyle())
            .searchable(text: $query)
            .navigationTitle("Chats")
            .navigationBarItems(trailing: Button(action: {}) {
                Image(systemName: "square.and.pencil")
            })
        }
    }
}



