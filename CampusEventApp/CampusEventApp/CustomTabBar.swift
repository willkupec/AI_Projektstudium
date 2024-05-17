//
//  CustomTabBar.swift
//  CampusEventApp
//
//  Created on 17.05.24.
//

import SwiftUI

//Symbols for Nav bar
//nur Icons die .fill haben
enum Tab: String, CaseIterable {
    case house
    case newspaper
    case message
    case bell
    case person
}

struct CustomTabBar: View {
    
    //function to make Symbol .fill when clicked
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .foregroundColor(selectedTab == tab ? .green : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial) //can change between light and dark mode
            .cornerRadius(10)
            .padding()
            
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.house))
    }
}
