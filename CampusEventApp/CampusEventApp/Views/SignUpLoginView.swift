import SwiftUI
import Firebase

//Erst wenn wir das auch nehmen als View brauchen wir das

/*class FirebaseManager: NSObject {
    let auth: Auth
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
}*/

struct SignUpLoginView: View {
    @State private var email = ""
    @State private var password = ""
    @Binding var isLoggedIn: Bool
    @State private var isLoginMode: Bool = true
    
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo_HTW_Berlin.svg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200, maxHeight: 200)
                    .padding(.bottom, 20)
                
                VStack(spacing: 16) {
                    Text(isLoginMode ? "Login" : "Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        if isLoginMode {
                            loginUser()
                        } else {
                            createNewAccount()
                            showAlert = true
                        }
                    }) {
                        Text(isLoginMode ? "Login" : "Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        isLoginMode.toggle()
                    }) {
                        Text(isLoginMode ? "Don't have an account? Sign Up" : "Already have an account? Login")
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 10)
                }
                .padding(.top, 15)
                .padding(.bottom, 15)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            if !UserDefaults.standard.bool(forKey: "hasOpenedBefore") {
                isLoginMode = false
                UserDefaults.standard.set(true, forKey: "hasOpenedBefore")
            } else {
                isLoginMode = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Account erstellt!"), message: Text("Ihr Account wurde erstellt und erfolgreich gespeichert"), dismissButton: .default(Text("OK")))
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
