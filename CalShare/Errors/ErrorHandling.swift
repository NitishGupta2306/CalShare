//
//  ErrorHandling.swift
//  CalShare
//
//  Created by Nitish Gupta on 2/14/24.
//

import Foundation

struct AuthenticationError: Error {
    let errorCode: String
    let message: String

    // Added Error messages
    static let getUserFail = AuthenticationError(errorCode: "get_user_failed", message: "Could not find user details")
}
