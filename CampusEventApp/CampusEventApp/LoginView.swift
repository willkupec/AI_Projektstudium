//
//  ContentView.swift
//  TestApp
//
//  Created on 14.05.24.
//

import SwiftUI
import Firebase

class FirebaseManager: NSObject {    //This is a fix for previewing the ios app otherwise it would not load
    
    let auth: Auth
    
    static let shared = FirebaseManager()  //Singelton object
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        super.init()
    }
}


struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedIn  = false
    
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
                
                VStack {
                    HStack {
                        Text("Login")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(alignment: .leading)
                    }
                    
                    TextField("Email/Matrikelnummer", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .cornerRadius(20)
                        .frame(width: 300, height: 40)
                        .shadow(radius: 5, x: 0, y: 5)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .cornerRadius(20)
                        .frame(width: 300, height: 40)
                        .shadow(radius: 5, x: 0, y: 5)
                    
                    Button(action: {
                        loginUser()
                    }, label: {
                        Text("Login")
                            .frame(width: 300, height: 40)
                            .foregroundColor(.black)
                            .background(Color.green)
                    })
                    .cornerRadius(50)
                    .shadow(radius: 5, x: 0, y: 5)
                }
                .frame(width: 350, height: 300, alignment: .center)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(30)
            }
        }
    }
    
    func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to log in", err)
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            isSignedIn = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
