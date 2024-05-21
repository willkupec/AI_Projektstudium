//
//  MainView.swift
//  CampusEventApp
//
//  Created by Reinardus on 18.05.24.
//

import SwiftUI

struct MainView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    
    var body: some View {
        
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
         
         NotificationView()
         .tabItem() {
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

#Preview {
    MainView()
}
