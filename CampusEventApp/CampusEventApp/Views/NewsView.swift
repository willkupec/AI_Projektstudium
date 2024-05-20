//
//  NewsView.swift
//  CampusEventApp
//
//  Created by Reinardus on 18.05.24.
//

import SwiftUI

struct NewsView: View {
    var body: some View {
        ZStack {
            Image("hintergrund")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image(systemName: "bell.fill")
                .foregroundColor(Color.black)
                .font(.system(size: 100.0))
        }
    }
}

#Preview {
    NewsView()
}
