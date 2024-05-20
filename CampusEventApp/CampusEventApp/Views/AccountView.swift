//
//  AccountView.swift
//  CampusEventApp
//
//  Created by Reinardus on 18.05.24.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        ZStack {
            Image("hintergrund")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image(systemName: "person.fill")
                .foregroundColor(Color.black)
                .font(.system(size: 100.0))
        }
    }
}

#Preview {
    AccountView()
}
