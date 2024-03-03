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

struct GroupError: Error {
    let errorCode: String
    let message: String
    
    static let getGroupDataError = AuthenticationError(errorCode: "get_group_data_failed", message: "Could not fetch group data of that group")
    static let getGroupsUserIsInError = AuthenticationError(errorCode: "get_groups_user_is_in_failed", message: "Could not fetch groups that users is in")
    static let setGroupDataFail = AuthenticationError(errorCode: "Set_Group_Data_Fail", message: "Could not set user in group")
    static let createGroupFail = AuthenticationError(errorCode: "create_group_fail", message: "Could not create group")
    static let deleteGroupFail = AuthenticationError(errorCode: "delete_group_fail", message: "Could not delete group")
    static let tooManyUsersInGroup = AuthenticationError(errorCode: "too_many_users_in_group", message: "Could not delete group")
    

}
