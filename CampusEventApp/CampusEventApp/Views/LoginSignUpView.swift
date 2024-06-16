//
//  LoginSignUpView.swift
//  CampusEventApp
//
//  Created on 04.06.24.
//

import SwiftUI
import Firebase


class FirebaseManager: NSObject {    //This is a fix for previewing the ios app otherwise it would not load
    
    let auth: Auth
    
    let firestore: Firestore
    
    static let shared = FirebaseManager()  //Singelton object
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
}

struct LoginSignUpView: View {
    @State private var email = ""
    @State private var password = ""
    
    @Binding var isLoggedIn: Bool // here is the Binding
    
    @State var isLoginMode = true;
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                
                Picker(selection: $isLoginMode, label: Text("Picker here")) {
                    Text("Login")
                        .tag(true)
                    Text("Create Account")
                        .tag(false)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                
                
                
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
                                
                                if isLoginMode {
                                    Text("Login")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .frame(alignment: .leading)
                                } else {
                                    Text("Sign In")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .frame(alignment: .leading)
                                }
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
                            
                            if isLoginMode {
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
                            } else {
                                Button(action: {
                                    createNewAccount()
                                }, label: {
                                    Text("Create Account")
                                        .frame(width: 300, height: 40)
                                        .foregroundColor(.black)
                                        .background(Color.green)
                                })
                                .cornerRadius(50)
                                .shadow(radius: 5, x: 0, y: 5)
                            }
                        }
                        .frame(width: 350, height: 300, alignment: .center)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(30)
                    }
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
    
    
    
    func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to log in", err)
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            isLoggedIn = true
        }
    }
    
    
    
}

struct LoginSignUpView_Previews: PreviewProvider {
    
     @State static var isLoggedIn = false

    static var previews: some View {
        LoginSignUpView(isLoggedIn: $isLoggedIn)
    }
}
