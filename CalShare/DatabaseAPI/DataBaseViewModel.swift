//
//  DataBaseViewModel.swift
//  CalShare
//
//  Created by Jonathan Vazquez on 3/1/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class DBViewModel {
    static let shared = DBViewModel()
    var db: Firestore
    
    // TODO get groups user is in through mem or db
    init() {
        //FirebaseApp.configure()
        self.db = Firestore.firestore()
    }
    
    // Will now overwrite any data that is already in db
    func updateCurrUserData() async throws {
        let env = "Users"
        do {
            let currUser = try AuthenticationHandler.shared.checkAuthenticatedUser()
            let calData = await CalendarViewModel.shared.convertDataToDouble()
            
            let docRef = db.collection(env).document(currUser.uid)
            try await docRef.updateData(
                ["Events" : calData]
            )
        } catch {
            throw GroupError.updateCurrUserData
        }
    }

    func addUserToGroup(groupID: String) async throws{
        let env = "Groups"
        Task{
            do{
                var groupData = try await getGroupData(groupID: groupID)
                let currUser = try AuthenticationHandler.shared.checkAuthenticatedUser()
                
                let userID = currUser.uid
                let currGroupRef = db.collection(env).document(groupID)
                
                if (userInGroup(UID: userID, group: groupData)) {throw GroupError.userAlreadyInGroup}
                
                let emptyUser = getFirstEmptyUser(group: groupData)
                if (emptyUser == "") {throw GroupError.tooManyUsersInGroup}
                
                try await currGroupRef.updateData(
                    [emptyUser : userID]
                )
                print("Successfully added user to group")
                
            }
            catch{
                throw GroupError.setGroupDataFail
            }
        }
    }
    
    // TODO: Have it work with local "cache" ie check if client has fetched the group before
    // Should return array of 1 item bc groupIds are unique
    func getGroupData(groupID: String) async throws -> Group {
        let env = "Groups"
        let docRef = db.collection(env).document(groupID)
        do {
            let groupData =  try await docRef.getDocument(as: Group.self)
            return groupData
        } catch {
            print("Could not get group data of group: " + groupID)
            throw GroupError.getGroupDataError
        }
    }
    
    // TODO: Have it work with local "cache" ie check if client has fectched the users already
    // Will return array of data of all users in group
    func getUserDataFromUsersInGroup(groupID: String) async throws -> [User] {
        let env = "Users"
        var users: [User] = []
        let groupData = try await getGroupData(groupID: groupID)
        
        var validUserIDs: [String] = getNonEmptyUIDsInGroup(group: groupData)
        
        let docRef = db.collection(env).whereField(FieldPath.documentID(), in: validUserIDs)
        do {
            let querySnapshot = try await docRef.getDocuments()
            for document in querySnapshot.documents {
                let user = try document.data(as: User.self)
                users.append(user)
            }
            return users
        } catch {
            throw GroupError.getUsersInGroupFail
        }
        
    }
    
    func getNonEmptyUIDsInGroup(group: Group) -> [String] {
        var nonEmptyUIDS: [String] = []
        if (group.User0 != "") {nonEmptyUIDS.append(group.User0)}
        if (group.User1 != "") {nonEmptyUIDS.append(group.User1)}
        if (group.User2 != "") {nonEmptyUIDS.append(group.User2)}
        if (group.User3 != "") {nonEmptyUIDS.append(group.User3)}
        if (group.User4 != "") {nonEmptyUIDS.append(group.User4)}
        if (group.User5 != "") {nonEmptyUIDS.append(group.User5)}
        if (group.User6 != "") {nonEmptyUIDS.append(group.User6)}
        if (group.User7 != "") {nonEmptyUIDS.append(group.User7)}
        
        return nonEmptyUIDS
    }
    
    // Will return the first empty user in the group or empty if all full
    func getFirstEmptyUser(group: Group) -> String {
        if (group.User0 == "") {return "User0"}
        if (group.User1 == "") {return "User1"}
        if (group.User2 == "") {return "User2"}
        if (group.User3 == "") {return "User3"}
        if (group.User4 == "") {return "User4"}
        if (group.User5 == "") {return "User5"}
        if (group.User6 == "") {return "User6"}
        if (group.User7 == "") {return "User7"}
        return ""
    }
    
    // Will return list of all the events of a user, meant to be used in conjunction with above
    func getEventsOfUsers(users: [User]) -> [Double] {
        var events: [Double] = []
        for user in users {
            events.append(contentsOf: user.events)
        }
        return events
    }
    
    // Will return data of a single user
    func getUserData(userID: String) async throws -> User {
        let env = "Users"
        let docref = db.collection(env).document(userID)
        do {
            let userData = try await docref.getDocument(as: User.self)
            return userData
        } catch {
            print("Could not get user data of user: "+userID)
            throw GroupError.getUserDataFail
        }
    }
    
    func getAllGroupsUserIsIn() async throws -> [Group] {
        do {
            var groupsUserIsIn: [Group] = []
            let currUser = try AuthenticationHandler.shared.checkAuthenticatedUser()
            
            let querySnapshot = try await db.collection("Groups").whereFilter(Filter.orFilter([
                Filter.whereField("User0", isEqualTo: currUser.uid),
                Filter.whereField("User1", isEqualTo: currUser.uid),
                Filter.whereField("User2", isEqualTo: currUser.uid),
                Filter.whereField("User3", isEqualTo: currUser.uid),
                Filter.whereField("User4", isEqualTo: currUser.uid),
                Filter.whereField("User5", isEqualTo: currUser.uid),
                Filter.whereField("User6", isEqualTo: currUser.uid),
                Filter.whereField("User7", isEqualTo: currUser.uid),
            ])).getDocuments()
            
            for document in querySnapshot.documents {
                let group = try document.data(as: Group.self)
                groupsUserIsIn.append(group)
            }
            
            return groupsUserIsIn
        } catch {
            throw GroupError.getGroupsUserIsInError
        }
    }
    
    // Will create a new group and add the user that created it.
    //  Will then return the groupID of the group that was made
    func createNewGroupAndAddCurrUser() async throws -> String {
        let env = "Groups"
        
        do {
            
            let calData = await CalendarViewModel.shared.convertDataToDouble()
            let currUser = try AuthenticationHandler.shared.checkAuthenticatedUser()
            
            let ref = try await db.collection(env).addDocument(data: [
                "User0" : currUser.uid,
                "User1" : "",
                "User2" : "",
                "User3" : "",
                "User4" : "",
                "User5" : "",
                "User6" : "",
                "User7" : ""
            ])
            try await updateCurrUserData()
            print("Document added with ID: \(ref.documentID)")
            return ref.documentID
        } catch {
            throw GroupError.createGroupFail
        }
    }
    
    // IF YOU WISH TO USE THIS FUNCTION, DO NOT LOSE THE GROUPID IT RETURNS BECAUSE THEN THE GROUPID/GROUP WILL BE LOST
    // Will have to add a user to this group with the other function to not lose it
    func createNewGroup_DO_NOT_USE_THIS_FUNCTION() async throws -> String {
        let env = "Groups"
        
        do {
            let ref = try await db.collection(env).addDocument(data: [
                "User0" : "",
                "User1" : "",
                "User2" : "",
                "User3" : "",
                "User4" : "",
                "User5" : "",
                "User6" : "",
                "User7" : ""
            ])
            print("Document added with ID: \(ref.documentID)")
            return ref.documentID
        } catch {
            throw GroupError.createGroupFail
        }
    }
    
    // <Completed: Works> TODO: Check to see if this actually deletes everything, bc of
    //  {Warning: Deleting a document does not delete its subcollections!}
    func deleteGroup(groupID: String) async throws {
        let env = "Groups"
        do {
            try await db.collection(env).document(groupID).delete()
            print("Document successfully removed!")
        } catch {
            throw GroupError.deleteGroupFail
        }
    }
    
    func userInGroup(UID: String, group: Group) -> Bool {
        return group.User0 == UID ||
            group.User1 == UID ||
            group.User2 == UID ||
            group.User3 == UID ||
            group.User4 == UID ||
            group.User5 == UID ||
            group.User6 == UID ||
            group.User7 == UID
    }

}

struct User: Codable {
    @DocumentID var id: String? = ""
    var events: [Double]
}

struct Group: Codable {
    @DocumentID var id: String? = ""
    var User0: String = ""
    var User1: String = ""
    var User2: String = ""
    var User3: String = ""
    var User4: String = ""
    var User5: String = ""
    var User6: String = ""
    var User7: String = ""
}
