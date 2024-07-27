import SwiftUI
import Firebase

struct ChatUser : Identifiable{
    
    var id: String{ uid } //getter mach die uid zur identifiable id
    
    let name, username, email, uid, bio, profileImageURL: String
    let links: [String]
    
    init(data: [String: Any]){
        self.name = data["name"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.uid = data["uid"] as? String ?? ""
        self.bio = data["bio"] as? String ?? ""
        self.profileImageURL = data["profileImageURL"] as? String ?? ""
        self.links = data["links"] as? [String] ?? ["", ""]
    }
}

class ProfileViewModel: ObservableObject {
    @Published var chatUser: ChatUser?

    init() {
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not fetch uid")
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch current user: ", error)
                return
            }
            
            guard let data = snapshot?.data() else {
                print("No data found")
                return
            }
            let name = data["name"] as? String ?? ""
            let username = data["username"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let uid = data["uid"] as? String ?? ""
            let bio = data["bio"] as? String ?? ""
            let profileImageURL = data["profileImageURL"] as? String ?? ""
            let links = data["links"] as? [String] ?? ["", ""]
            
            DispatchQueue.main.async {
                self.chatUser = ChatUser(data: data)
            }
        }
    }
}

struct AccountView: View {
    @ObservedObject private var vm = ProfileViewModel()
    @Binding var isLoggedIn: Bool
    
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var bio: String = ""
    @State private var links: [String] = ["", ""]
    @State private var selectedImage: UIImage?
    @State private var showAlert = false
    @State private var isImagePickerPresented = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("My Account")
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
                    .padding(.leading, -5)
                
                Divider()
                    .background(Color.gray)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                
                VStack {
                    VStack {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 5)
                                .onTapGesture {
                                    isImagePickerPresented = true
                                }
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 5)
                            Button(action: {
                                isImagePickerPresented = true
                            }, label: {
                                Text("Edit profile image")
                                    .padding(.top, 10)
                            })
                        }
                    }
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(selectedImage: $selectedImage)
                    }
                }
                .frame(width: .infinity, height: 150)
                .padding(.top, 10)
                
                VStack {
                    HStack {
                        Text("Name")
                            .frame(maxWidth: 100, alignment: .leading)
                            .padding(.leading, 15)
                        
                        TextField("Name", text: $name)
                    }.padding(.top, 10)
                    
                    HStack {
                        Text("Username")
                            .frame(maxWidth: 100, alignment: .leading)
                            .padding(.leading, 15)
                        
                        TextField("Username", text: $username)
                    }.padding(.top, 20)
                    
                    HStack {
                        Text("Email")
                            .frame(maxWidth: 100, alignment: .leading)
                            .padding(.leading, 15)
                        
                        TextField("Email", text: $email)
                            .disabled(true)  // Email cannot be changed
                    }.padding(.top, 20)
                    
                    HStack(alignment: .top) {
                        Text("Links")
                            .frame(maxWidth: 100, alignment: .leading)
                            .padding(.leading, 15)
                        
                        VStack(alignment: .leading) {
                            ForEach(links.indices, id: \.self) { index in
                                HStack {
                                    TextField("Link", text: $links[index])
                                    
                                    Button(action: {
                                        links.remove(at: index)
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                                .padding(.top, index == 0 ? 0 : 9)
                            }
                            
                            Button(action: {
                                links.append("")
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add link")
                                }
                            }
                            .padding(.top, 9)
                            .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 15)
                    }
                    .padding(.top, 20)
                    
                    HStack {
                        Text("Bio")
                            .frame(maxWidth: 100, alignment: .leading)
                            .padding(.leading, 15)
                        
                        TextField("Bio", text: $bio)
                    }.padding(.top, 20)
                    
                    // Gap between Info and Buttons
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        Button(action: {
                            if let selectedImage = selectedImage {
                                uploadProfileImage(selectedImage) { url in
                                    if let url = url {
                                        storeUserInformation(imageProfileURL: url)
                                    }
                                }
                            } else {
                                storeUserInformation(imageProfileURL: nil)
                            }
                            showAlert = true
                        }, label: {
                            Text("Speichern")
                                .frame(width: 200, height: 40)
                                .foregroundColor(.black)
                                .background(Color.green)
                        })
                        .cornerRadius(50)
                        .shadow(radius: 5, x: 0, y: 5)
                        
                        Button(action: {
                            logOut()
                        }, label: {
                            Text("Log Out")
                                .frame(width: 100, height: 40)
                                .foregroundColor(.black)
                                .background(Color.red)
                        })
                        .cornerRadius(50)
                        .shadow(radius: 5, x: 0, y: 5)
                    }
                }
                .onAppear {
                    vm.fetchCurrentUser()
                }
                .onReceive(vm.$chatUser) { chatUser in
                    if let chatUser = chatUser {
                        updateStateWithChatUser(chatUser)
                    }
                }
            }
        }
        .navigationBarTitle("Title")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Gespeichert"), message: Text("Ihre Änderungen wurden erfolgreich gespeichert"), dismissButton: .default(Text("OK")))
        }
    }
    
    private func updateStateWithChatUser(_ chatUser: ChatUser) {
        name = chatUser.name
        username = chatUser.username
        email = chatUser.email
        bio = chatUser.bio
        links = chatUser.links
        if let url = URL(string: chatUser.profileImageURL) {
            fetchImage(from: url) { image in
                self.selectedImage = image
            }
        }
    }
    
    private func storeUserInformation(imageProfileURL: URL?) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        
        let imageURLString = imageProfileURL?.absoluteString ?? ""
        
        let userData = ["name" : self.name, "username" : self.username, "email" : self.email, "uid" : uid, "bio" : self.bio, "profileImageURL": imageURLString, "links" : self.links] as [String : Any]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
                print("Successfully stored UserData")
            }
    }
    
    private func logOut() {
        do {
            try FirebaseManager.shared.auth.signOut()
            isLoggedIn = false
            print("User logged out successfully")
        } catch let error {
            print("Failed to log out: \(error.localizedDescription)")
        }
    }
    
    private func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to fetch image:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Failed to create UIImage from data")
                completion(nil)
            }
        }.resume()
    }
    
    private func uploadProfileImage(_ image: UIImage, completion: @escaping (URL?) -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            completion(nil)
            return
        }
        
        let ref = FirebaseManager.shared.storage.reference().child("profile_images/\(uid).jpg")
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(nil)
            return
        }
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image:", error)
                completion(nil)
                return
            }
            
            ref.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL:", error)
                    completion(nil)
                    return
                }
                
                if let url = url {
                    completion(url)
                } else {
                    print("Download URL is nil")
                    completion(nil)
                }
            }
        }
    }

}





