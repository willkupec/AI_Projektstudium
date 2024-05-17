//
//  HomeView_CustomTabBar_Test.swift
//  CampusEventApp
//
//  Created on 17.05.24.
//

import SwiftUI

struct HomeView_CustomTabBar_Test: View {
    @State private var selectedTab: Tab = .house
    
    init() { //not reserving Space for Tab View
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        HStack {
                            Image(systemName: tab.rawValue)
                            Text("\(tab.rawValue.capitalized)")
                                .bold()
                                .animation(nil, value: selectedTab)
                        }
                        .tag(tab)
                    }
                }
            }
            
            
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
    }
}

#Preview {
    HomeView_CustomTabBar_Test()
}
