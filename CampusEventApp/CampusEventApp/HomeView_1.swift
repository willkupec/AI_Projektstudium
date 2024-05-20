//
//  HomeView_1.swift
//  CampusEventApp
//
//  Created on 17.05.24.
//

import SwiftUI

struct HomeView_1: View {
    var body: some View {
        VStack {
            //HeaderView
            
            ScrollView(.vertical, showsIndicators: false){
                // LoginView()
                //ScrollView
            }
            
            ExtractedView() 
        }
    }
}

#Preview {
    HomeView_1()
}

struct ExtractedView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            HStack{
                Image(systemName: "house")
                Spacer()
                Image(systemName: "magnifyingglass")
                Spacer()
                Image(systemName: "message")
                Spacer()
                Image(systemName: "bell")
                Spacer()
                Image(systemName: "person")
                //Image("profilepicture")
                //     .resizable()
                //     .frame(width:24, height,24)
                //     .cornerRadius(24)
            }
            .font(.system(size: 24))
            .padding(.horizontal,24)
            .padding(.top, 12)
        }
    }
}
