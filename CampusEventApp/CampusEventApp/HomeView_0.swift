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
                TabItemView(title: "Home")
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
            
                // LoginView()  //war nur zum ausprobieren
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(1)
                
                Text("Reels")
                    .tabItem {
                        Image(systemName: "message")
                        Text("Reels")
                    }
                    .tag(2)
                
                Text("Activity")
                    .tabItem {
                        Image(systemName: "newspaper")
                        Text("Activity")
                    }
                    .tag(3)
                
                Text("Profile")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(4)
            }
            .accentColor(.purple) // Farbe der Tab-Leiste anpassen
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


