//
//  ContentView.swift
//  TestApp
//
//  Created on 14.05.24.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            Image("hintergrund")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
        
            VStack {
                Image("Logo_HTW_Berlin.svg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200, maxHeight: 200)
                    .padding()
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                
                VStack{
                    HStack {
                        Text("Sign up")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(alignment: .leading)
                    }
        
                    
                    TextField("Email/Matrikelnummer", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .cornerRadius(20)
                        .frame(width: 300, height: 40)
                        .shadow(radius: 5, x:0, y:5)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .cornerRadius(20)
                        .frame(width: 300, height: 40)
                        .shadow(radius: 5, x:0, y:5)
                    Button(action: {
                    }, label: {
                        Text("Create account")
                            .frame(width: 300, height: 40)
                            .foregroundColor(.black)
                            .background(Color.green)
                    })
                    .cornerRadius(50)
                    .shadow(radius: 5, x:0 , y:5)
                }
                .frame(width: 350, height: 300, alignment: .center)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(30)
                
            }
        }
    }
}

    
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
