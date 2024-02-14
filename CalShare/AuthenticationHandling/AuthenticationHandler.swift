//
//  AuthenticationHandler.swift
//  CalShare
//
//  Created by Nitish Gupta on 2/14/24.
//

import Foundation
import FirebaseAuth


final class AuthenticationHandler {
    static let shared = AuthenticationHandler()
    private init(){ }
    
    func createrNewUser(email: String, pass: String) async throws -> AuthResponseDetails{
        // Asynchrnous createUser from FirebaseAuth
        let AuthResp = try await Auth.auth().createUser(withEmail: email, password: pass)
        return AuthResponseDetails(user: AuthResp.user)
    }
    
    func checkAuthenticatedUser() throws -> AuthResponseDetails{
        guard let userFound = Auth.auth().currentUser else{
            throw AuthenticationError.getUserFail
        }
        return AuthResponseDetails(user: userFound)
    }
    
}

// Response from FireBaseAuth CreateUser.
struct AuthResponseDetails{
    let uid : String
    let email : String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
    }
}
