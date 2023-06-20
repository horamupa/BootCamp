//
//  AuthBoy.swift
//  Trip Map
//
//  Created by MM on 22.05.2023.
//

import SwiftUI
import FirebaseAuth

final class AuthBoy {
    
    static let share = AuthBoy()
    private init() {}
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            print("no current user avalible")
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let response = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: response.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let response = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: response.user)
    }
    
    @discardableResult
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}

struct AuthDataResultModel {
    let id: String
    let email: String?
    let photoURL: String?
    
    init(user: User) {
        self.id = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
}

