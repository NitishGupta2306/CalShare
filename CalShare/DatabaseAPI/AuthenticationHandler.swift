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
    
    @discardableResult
    func createrNewUser(email: String, pass: String) async throws -> AuthResponseDetails{
        // Asynchrnous createUser from FirebaseAuth
        let AuthResp = try await Auth.auth().createUser(withEmail: email, password: pass)
        return AuthResponseDetails(uid: AuthResp.user.uid, email: AuthResp.user.email)
    }
    
    @discardableResult
    func signInUser(email: String, pass: String) async throws -> AuthResponseDetails{
        // Asynchrnous createUser from FirebaseAuth
        let AuthResp = try await Auth.auth().signIn(withEmail: email, password: pass)
        return AuthResponseDetails(uid: AuthResp.user.uid, email: AuthResp.user.email)
    }
    
    func checkAuthenticatedUser() throws -> AuthResponseDetails{
        guard let userFound = Auth.auth().currentUser else{
            throw AuthenticationError.getUserFail
        }
        return AuthResponseDetails(uid: userFound.uid, email: userFound.email)
    }
    
    func signOut() throws{
        try Auth.auth().signOut()
    }
    
    func passReset(email: String) async throws{
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
}

// Response from FireBaseAuth CreateUser.
struct AuthResponseDetails{
    let uid : String
    let email : String?
    
    init(uid: String, email: String?){
        self.uid = uid
        self.email = email
    }
}

// Database Push
