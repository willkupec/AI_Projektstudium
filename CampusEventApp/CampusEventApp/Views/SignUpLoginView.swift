import SwiftUI
import Firebase
import FirebaseStorage


class FirebaseManager: NSObject {    //This is a fix for previewing the ios app otherwise it would not load
    
    let auth: Auth
    let firestore: Firestore
    let storage: Storage
    
    static let shared = FirebaseManager()  //Singelton object
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.storage = Storage.storage()
        
        super.init()
    }
}

struct SignUpLoginView: View {
    @State private var email = ""
    @State private var password = ""
    @Binding var isLoggedIn: Bool
    @State private var isLoginMode: Bool = true
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
                        Task {
                            if isLoginMode {
                                await loginUser()
                            } else {
                                await validateAndCreateNewAccount()
                            }
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
            Alert(title: Text("Hinweis"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func fetchRandomUsername() async -> String {
        let url = URL(string: "https://randomuser.me/api/")!

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let results = json["results"] as? [[String: Any]],
               let login = results.first?["login"] as? [String: Any],
               let username = login["username"] as? String {
                return username
            } else {
                return "DefaultUsername"
            }
        } catch {
            print("Failed to fetch random username: ", error)
            return "DefaultUsername"
        }
    }

    private func validateAndCreateNewAccount() async {
        if password.count < 6 {
            alertMessage = "Das Passwort muss mindestens 6 Zeichen lang sein."
            showAlert = true
            return
        }

        if !isValidEmail(email) {
            alertMessage = "Bitte geben Sie eine gültige E-Mail-Adresse ein."
            showAlert = true
            return
        }

        await createNewAccount()
    }

    private func createNewAccount() async {
        do {
            let result = try await FirebaseManager.shared.auth.createUser(withEmail: email, password: password)
            let userId = result.user.uid
            print("Successfully created user: \(userId)")

            let randomUsername = await fetchRandomUsername()

            let userData: [String: Any] = [
                "name": "",
                "username": randomUsername,
                "email": email,
                "uid": userId,
                "bio": "",
                "profileImageURL": "",
                "links": ["", ""]
            ]

            try await FirebaseManager.shared.firestore.collection("users").document(userId).setData(userData)
            print("Successfully stored UserData")

            alertMessage = "Ihr Account wurde erfolgreich erstellt."
            showAlert = true
            await loginUser()
        } catch {
            alertMessage = "Fehler beim Erstellen des Kontos: \(error.localizedDescription)"
            showAlert = true
        }
    }

    func loginUser() async {
        do {
            let result = try await FirebaseManager.shared.auth.signIn(withEmail: email, password: password)
            print("Successfully logged in as user: \(result.user.uid)")
            isLoggedIn = true
        } catch {
            alertMessage = "Fehler beim Anmelden: \(error.localizedDescription)"
            showAlert = true
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
