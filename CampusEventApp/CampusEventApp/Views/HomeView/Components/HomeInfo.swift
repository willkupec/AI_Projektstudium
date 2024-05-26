//
//  HomeInfo.swift
//  CampusEventApp
//
//  Created on 26.05.24.
//

import SwiftUI

struct HomeInfo: View {
    var body: some View {
        VStack{
            HStack {
                Text("News")
                    .padding(.leading, 20)
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus.")
                .padding(.leading, 20)
                .padding(.trailing, 20)
        }
        
            
    }
}

#Preview {
    HomeInfo()
}
