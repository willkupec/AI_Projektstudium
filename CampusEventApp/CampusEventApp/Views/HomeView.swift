//
//  HomeView.swift
//  CampusEventApp
//
//  Created by Reinardus on 18.05.24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Image("hintergrund")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image(systemName: "house.fill")
                .foregroundColor(Color.black)
                .font(.system(size: 100.0))
        }
    }
}

#Preview {
    HomeView()
}
