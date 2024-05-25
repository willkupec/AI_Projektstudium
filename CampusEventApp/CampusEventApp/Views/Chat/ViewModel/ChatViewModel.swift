//
//  ChatViewModel.swift
//  CampusEventApp
//
//  Created on 25.05.24.
//

import Foundation

class ChatsViewModel: ObservableObject {
    
    @Published var chats = Chat.sampleChat
    
    func getSortedFilteredChats(query: String) -> [Chat] {
        let sortedChats = chats.sorted{
            guard let date1 = $0.messages.last?.date else { return false }
            guard let date2 = $1.messages.last?.date else { return false }
            return date1 > date2
        }
        
        if query == "" {
            return sortedChats
        }
        return sortedChats.filter { $0.person.name.lowercased().contains(query.lowercased()) }
    }
    
    func markAsUnread(_ newValue: Bool, chat: Chat) {    //Nachrichten als Read makieren wenn Chat geöffnet wird
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats[index].hasUnreadMessage = newValue
        }
    }
    
    
    func sendMessage(_ text: String, in chat: Chat) -> Message? {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            let messages = Message(text, type: .Sent)
            chats[index].messages.append(messages)
            return messages
        }
        return nil
    }
}
