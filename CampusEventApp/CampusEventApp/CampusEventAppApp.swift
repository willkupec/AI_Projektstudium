//
//  CampusEventAppApp.swift
//  CampusEventApp
//
//  Created on 17.05.24.
//

import SwiftUI


@main
struct CampusEventAppApp: App {
    
    @State var isLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if !isLoggedIn {
                //LoginSignUpView(isLoggedIn: $isLoggedIn)
                SignUpLoginView(isLoggedIn: $isLoggedIn)
            } else {
                MainView(isLoggedIn: $isLoggedIn)
            }
            
        }
    }
}
