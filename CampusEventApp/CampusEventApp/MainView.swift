import SwiftUI

struct MainView: View {
    
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
                
                AccountView()
                    .tabItem {
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

#Preview {
    MainView()
}
