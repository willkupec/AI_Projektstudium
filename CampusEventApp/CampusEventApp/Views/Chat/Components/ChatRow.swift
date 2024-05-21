//
//  ChatRow.swift
//  CampusEventApp
//
//  Created on 21.05.24.
//

import SwiftUI

struct ChatRow: View {
    
    let chat: Chat
    
    var body: some View {
        HStack{
            Image(systemName: chat.person.imgString)
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            
            ZStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(chat.person.name)
                            .bold()
                        
                        Spacer()
                        
                        Text(chat.messages.last?.date.description ?? "")
                        
                    }
                    
                    HStack {
                        Text(chat.messages.last?.text ?? "")
                            .foregroundColor(.gray)
                            .lineLimit(2)
                            .frame(height: 50, alignment: .top)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.trailing, 40)
                    }
                }
                
                Circle()
                    .foregroundColor(chat.hasUnreadMessage ? .green : .clear)
                    .frame(width: 18, height: 18)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(height: 80)
    }
}

#Preview {
    ChatRow(chat: Chat.sampleChat[0])
}
