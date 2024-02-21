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
}

struct User: Codable {
    let email: String?
    let password: String?
}
