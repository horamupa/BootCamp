//
//  AuthViewViewModel.swift
//  Trip Map
//
//  Created by MM on 22.05.2023.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        print("button pressed")
        guard !email.isEmpty && !password.isEmpty else {
            print("bad auth data from user")
            return
        }
        
        let _ = try await AuthBoy.share.createUser(email: email, password: password)
    }
    
    func signIn() async throws {
        
    }
    
    func resetPassword() async throws {
//       try AuthBoy.share.resetPassword(email: email)
    }
}
