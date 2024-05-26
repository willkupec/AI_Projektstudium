//
//  HomeView.swift
//  CampusEventApp
//
//  Created by Reinardus on 18.05.24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HomeInfo()
                .frame(minHeight: 200 , maxHeight: 250)
            Divider()
            ScrollView {
                HomeTokens()
            }
        }
    }
}

struct HomeView_1_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
