//
//  HomeView.swift
//  CampusEventApp
//
//  Created by Reinardus on 18.05.24.
//

import SwiftUI

struct ChatView: View {
    
    let chats = Chat.sampleChat
    
    var body: some View {
        NavigationView {
            List {
                /*ForEach(0 ..< 10) {i in
                    ChatRow()
                }*/
                
                ForEach(chats) { chat in
                    ChatRow(chat: chat)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Chats")
            .navigationBarItems(trailing: Button(action: {}) {
                Image(systemName: "square.and.pencil")
            })
        }
    }
}


#Preview {
    ChatView()
}
