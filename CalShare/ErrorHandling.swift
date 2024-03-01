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
    static let signOutError = AuthenticationError(errorCode: "sign_out_failed", message: "Could not signout user")
    static let signUpError = AuthenticationError(errorCode: "sign_up_failed", message: "Could not signup user")
    static let signInError = AuthenticationError(errorCode: "sign_in_failed", message: "Could not signin user")
    static let passResetError = AuthenticationError(errorCode: "passReset_Failed", message: "Could not send reset email")
}
