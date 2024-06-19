import SwiftUI

struct MainView: View {
    
    @Binding var isLoggedIn: Bool
    
    
    
    var body: some View {
        NavigationView {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                NewsView()
                    .tabItem {
                        Image(systemName: "newspaper.fill")
                        Text("HTW News")
                    }
                
                ChatView()
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("Chats")
                    }
                
                EventsView()
                    .tabItem {
                        Image(systemName: "bell.fill")
                        Text("Events")
                    }
                
                
                AccountView(isLoggedIn: $isLoggedIn)
                    .tabItem() {
                        Image(systemName: "person.fill")
                        Text("My Account")
                    }
            }
            .accentColor(.green)
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor.white
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}


