//
//  AuthUtil.swift
//  CampusEventApp
//
//  Created by Reinardus on 02.07.24.
//

import Foundation
import FirebaseAuth

public func getUsername(completion: @escaping (String) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else {
        completion("Anonymous")
        return
    }
    
    print("\(uid)")
    FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
        if let error = error {
            print("Failed to fetch current user: ", error)
            completion("Anonymous")
            return
        }
        
        guard let data = snapshot?.data() else {
            print("No data found")
            completion("Anonymous")
            return
        }
        print("Data: \(data.description)")
        
        let name = data["name"] as? String ?? "Anonymous"
        
        completion(name)
    }
}
