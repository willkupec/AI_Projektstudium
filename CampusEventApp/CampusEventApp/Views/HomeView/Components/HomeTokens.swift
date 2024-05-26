//
//  HomeTokens.swift
//  CampusEventApp
//
//  Created on 26.05.24.
//

import SwiftUI

struct HomeTokens: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                }
                .foregroundColor(.black)
                .frame(width: 125, height: 125)
                .background(Color.blue)
                .cornerRadius(15)
                
                Spacer()
                
                Button(action: {}){
                    Text("Button")
                }
                .foregroundColor(.black)
                .frame(width: 125, height: 125)
                .background(Color.blue)
                .cornerRadius(15)
                
                Spacer()
            }
            .padding(.vertical, 10)
            
            HStack {
                Spacer()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                }
                .foregroundColor(.black)
                .frame(width: 125, height: 125)
                .background(Color.blue)
                .cornerRadius(15)
                
                Spacer()
                
                Button(action: {}){
                    Text("Button")
                }
                .foregroundColor(.black)
                .frame(width: 125, height: 125)
                .background(Color.blue)
                .cornerRadius(15)
                
                Spacer()
            }
            .padding(.vertical, 10)
            
            HStack {
                Spacer()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                }
                .foregroundColor(.black)
                .frame(width: 125, height: 125)
                .background(Color.blue)
                .cornerRadius(15)
                
                Spacer()
                
                Button(action: {}){
                    Text("Button")
                }
                .foregroundColor(.black)
                .frame(width: 125, height: 125)
                .background(Color.blue)
                .cornerRadius(15)
                
                Spacer()
            }
            .padding(.vertical, 10)
        }
    }
}

#Preview {
    HomeTokens()
}
