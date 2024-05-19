//
//  SignUpView_0.swift
//  TestApp
//
//  Created on 15.05.24.
//

import SwiftUI

struct SignUpView_0: View {
    @State private var vorname = ""
    @State private var nachname = ""
    @State private var matrikelnummer = ""
    @State private var password = ""
    
    
    var body: some View {
        VStack {
            Spacer()
            Image("Logo_HTW_Berlin.svg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.top, 100)
                .padding(.bottom, 20)
            
            VStack{
                Spacer()
                
                HStack {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 35)
                    Spacer()
                }
                TextField("Vorname", text: $vorname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(20)
                    .frame(height: 40)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .shadow(radius: 5, x:0, y:5)
                
                TextField("Nachname", text: $nachname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(20)
                    .frame(height: 40)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .shadow(radius: 5, x:0, y:5)
                
                TextField("Matrikelnummer", text: $matrikelnummer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(20)
                    .frame(height: 40)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .shadow(radius: 5, x:0, y:5)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(20)
                    .frame(height: 40)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .shadow(radius: 5, x:0, y:5)
                
                Button(action: {
                    //perform Login
                }){
                    Text("Next")
                        .foregroundColor(.white)
                        .frame(width: 270, height: 5)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(20)
                        .shadow(radius: 5, x:0 , y:5)
                }
                .padding()
                
                Spacer()
            }
            .background(
                VStack {
                    Spacer(minLength: 0)
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.gray.opacity(0.2))
                        .padding()
                    Spacer(minLength: 0)
                }
            )
            .padding()
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(
            Image("hintergrund")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
}

}


struct SignUpView_0_Previews: PreviewProvider {
static var previews: some View {
    SignUpView_0()
    }
}



