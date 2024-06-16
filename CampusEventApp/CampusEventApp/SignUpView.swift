//
//  ContentView.swift
//  TestApp
//
//  Created on 14.05.24.
//

import SwiftUI
import Firebase

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
                        createNewAccount()
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
        
    private func createNewAccount(){
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password){
            result, err in
            if let err = err {
                print("failed to create user: ", err)
                return;
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            
            let userData = ["name" : "", "username" : "", "email" : email, "uid" : result?.user.uid ?? "", "bio" : "", "profileImageURL": "", "links" : ["", ""]] as [String : Any]
            FirebaseManager.shared.firestore.collection("users")
                .document(result?.user.uid ?? "").setData(userData) { err in
                    if let err = err {
                        print(err)
                        return
                    }
                    print("Successfully stored UserData")
                }
        }
    }
    
    private func storeUserInformationAfterSignUp() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        let userData = ["name" : "", "username" : "", "email" : email, "uid" : uid, "bio" : "", "profileImageURL": "", "links" : ["", ""]] as [String : Any]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
                print("Successfully stored UserData")
            }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
