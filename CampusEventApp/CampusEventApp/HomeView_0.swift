//
//  HomeView.swift
//  TestApp
//
//  Created on 15.05.24.
//

import SwiftUI

struct HomeView_0: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
            
                NewsView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(1)
                
                ChatView()
                    .tabItem {
                        Image(systemName: "message")
                        Text("Reels")
                    }
                    .tag(2)
                
                NotificationView()
                    .tabItem {
                        Image(systemName: "newspaper")
                        Text("Activity")
                    }
                    .tag(3)
                
                AccountView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(4)
            }
            .accentColor(.green) // Farbe der Tab-Leiste anpassen
            .buttonStyle(PlainButtonStyle())
            
        }
    }



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView_0()
    }
}

    struct TabItemView: View {
        let title: String
        
        var body: some View {
            VStack {
                Text(title)
                    .font(.title)
                    .padding()
                Text("hi")
               
            }
        }
    }


