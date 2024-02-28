//
//  UserModel.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 2/21/24.
//

import SwiftUI

@MainActor class UserModel: ObservableObject {
    @Published var authToken: String?
    @Published var currentUser: User?
    
    func setEmail(email_string: String?) {
        self.currentUser?.email = email_string
    }
    
    func setPassword(password_string: String?) {
        self.currentUser?.email = password_string
    }
}

struct User: Codable {
    var email: String?
    var password: String?
}
