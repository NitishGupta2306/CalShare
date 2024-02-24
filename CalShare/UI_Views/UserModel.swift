//
//  UserModel.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 2/21/24.
//

import SwiftUI

@MainActor class UserModel: ObservableObject {
    @Published var authToken: String?
    @Published var curUser: User?
    
    private func setEmail(email_string: String?) {
        self.curUser?.email = email_string
    }
    
    private func setPassword(password_string: String?) {
        self.curUser?.email = password_string
    }
}

struct User: Codable {
    var email: String?
    var password: String?
}
