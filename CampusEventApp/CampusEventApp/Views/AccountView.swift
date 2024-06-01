import SwiftUI

struct AccountView: View {
    @State private var name: String = "Max Mustermann"
    @State private var username: String = "@username"
    @State private var email: String = "name@domain.com"
    @State private var link1: String = "website.net"
    @State private var link2: String = "mylink.net"
    @State private var link3: String = "yourlink.net"
    @State private var bio: String = "A description of this user."

    var body: some View {
            ZStack(alignment:.top) {
                Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack {
                    Text("Title")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 20)
                        .padding(.leading, -5)
                    
                    Divider()
                            .background(Color.gray)
                            .padding(.top, 2)
                            .padding(.bottom, 2)
                    
                    VStack {
                        Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center )
                        Button(action: {
                            editProfileImage()
                        }, label: {
                            Text("Edit profile image")
                                .padding(.top, 10)
                        })
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
                                .frame(maxWidth: 100,  alignment: .leading)
                                .padding(.leading, 15)
                            
                            VStack(alignment: .leading) {
                                TextField("Link", text: $link1)
                                
                                TextField("Link", text: $link2)
                                    .padding(.top, 9)
                                
                                TextField("Link", text: $link3)
                                    .padding(.top, 9)
                                
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Text("+ Add link")
                                })
                                .padding(.top, 9)
                                .foregroundColor(.gray)
                            }
                        }
                        .padding(.top, 20)
                        
                        HStack {
                            Text("Bio")
                                .frame(maxWidth: 100,  alignment: .leading)
                                .padding(.leading, 15)
                            
                            TextField("Bio", text: $bio)
                        }.padding(.top, 20)
                    }
                }
            } .navigationBarTitle("Title")
    }
    
    func editProfileImage() -> Void {
        // NOT YET IMPLEMENTED
        return
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
