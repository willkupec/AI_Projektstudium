//
//  LoginView.swift
//  CampusEventApp
//
//  Created by Reinardus on 19.05.24.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("hintergrund")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea() 
                
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    Button("Login") {
                        authenticateUser(username: username, password: password)
                    }.foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                    
                    NavigationLink(value: showingLoginScreen) {
                        
                    }
                }
                .padding()
            }
            .navigationDestination(isPresented: $showingLoginScreen) {
                MainView()
            }
            .navigationBarHidden(true)
        }
    }
    
    func authenticateUser(username: String, password: String) {
        //this is just an example, we should add real logic with DB later
        if  username.lowercased() == "correctusername" {
            wrongUsername = 0
            if password.lowercased() == "123" {
                wrongPassword = 0
                showingLoginScreen = true
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }
}

#Preview {
    LoginView()
}
