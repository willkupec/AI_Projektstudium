//
//  MainView.swift
//  CampusEventApp
//
//  Created by Reinardus on 18.05.24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
        
    NavigationView{ //trying to hidde navbar
            TabView {
                HomeView()
                    .tabItem() {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                NewsView()
                    .tabItem() {
                        Image(systemName: "newspaper.fill")
                        Text("HTW News")
                    }
                
                ChatView()
                    .tabItem() {
                        Image(systemName: "message.fill")
                        Text("Chats")
                    }
                
                EventsView()
                    .tabItem {
                        Image(systemName: "bell.fill")
                        Text("Notifications")
                    }
                
                
                AccountView()
                    .tabItem() {
                        Image(systemName: "person.fill")
                        Text("My Account")
                    }
                
            }
            .accentColor(.green)
        }
    }
}

#Preview {
    MainView()
}
