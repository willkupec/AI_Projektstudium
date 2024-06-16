import SwiftUI

struct ChatUser {
    let name, username, email, uid, bio, profileImageURL: String
    let links: [String]
}

class ProfileViewModel: ObservableObject{
    
    @Published var chatUser: ChatUser?
    
    init() {
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid
        else {
            print("Couldnt fetch uid")
            return
        }
        
        print("\(uid)")
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch current user: ", error)
            }
            
            guard let data = snapshot?.data() else {
                print("No data found")
                return
            }
            print("Data: \(data.description)")
            
            let name = data["name"] as? String ?? ""
            let username = data["username"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let uid = data["uid"] as? String ?? ""
            let bio = data["bio"] as? String ?? ""
            let profilImageURL = data["prodileImageURL"] as? String ?? ""
            let links = data["links"] as? [String] ?? ["", ""]
            let chatUser = ChatUser(name: name, username: username, email: email, uid: uid, bio: bio, profileImageURL: profilImageURL, links: links)
        }
    }
    
}

struct AccountView: View {
    
    @ObservedObject private var vm = ProfileViewModel()
    
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var bio: String = ""
    
    
    @State private var links: [String] = ["", ""]
    
    
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false

    var body: some View {
            ZStack(alignment:.top) {
                Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
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
                                    .scaledToFill() // Ensures the image fills the frame and can be clipped
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2)) // Optional: white border around the image
                                    .shadow(radius: 5) // Optional: shadow effect
                                Button(action: {
                                    isImagePickerPresented = true
                                }, label: {
                                    Text("Edit profile image")
                                        .padding(.top, 10)
                                })
                            } else {
                                Image(systemName: "person.circle")
                                        .resizable()
                                        .frame(width: 100, height: 100, alignment: .center )
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
                                .frame(maxWidth: 100,  alignment: .leading)
                                .padding(.leading, 15)
                            
                            TextField("Name", text: $name)
                        }.padding(.top, 10)
                        
                        HStack {
                            Text("Username")
                                .frame(maxWidth: 100,  alignment: .leading)
                                .padding(.leading, 15)
                            
                            TextField("Username", text: $username)
                        }.padding(.top, 20)
                        
                        HStack {
                            Text("Email")
                                .frame(maxWidth: 100,  alignment: .leading)
                                .padding(.leading, 15)
                            
                            TextField("Email", text: $email)
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
                                .frame(maxWidth: 100,  alignment: .leading)
                                .padding(.leading, 15)
                            
                            TextField("Bio", text: $bio)
                        }.padding(.top, 20)
                        
                        HStack {
                            Button(action: {
                                //Speicher Account Daten
                            }, label: {
                                Text("Speichern")
                                    .frame(width: 200, height: 40)
                                    .foregroundColor(.black)
                                    .background(Color.green)
                            })
                            .cornerRadius(50)
                            .shadow(radius: 5, x: 0, y: 5)
                            
                            
                            Button(action: {
                                //Speicher Account Daten
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
                }
            } .navigationBarTitle("Title")
    }
    
    
    
    func editProfileImage() -> Void {
        // NOT YET IMPLEMENTED
        return
    }
    /*
    private func persistImageStorage() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid
            else { return }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.selectedImage?.jpegData(compressionQuality: 0.5)
            else { return }
        ref.putData(imageData, metadata: nil?) { metadata, err in
            if let err = err {
                print("Failed to push image to Storage:  \(err)")
                return
            }
            ref.downloadURL {url, err in
                if let err = err {
                    print("Failed to retrieve downloadURL:  \(err)")
                    return
                }
                print("Successfully stored image with url: \(url?.absoluteString ?? "")")
            }
        }
     }
     */
    
    private func storeUserInformation(imageProfileURL: URL) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        let userData = ["name" : self.name, "username" : self.username, "email" : self.email, "uid" : uid, "bio" : self.bio, "profileImageURL": imageProfileURL.absoluteString, "links" : self.links] as [String : Any]
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

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
