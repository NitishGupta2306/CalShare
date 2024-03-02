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
    var UID: String
    var groups: [String]
    var db: Firestore
    
    // TODO get groups user is in through mem or db
    init(UID: String) {
        //FirebaseApp.configure()
        self.db = Firestore.firestore()
        self.UID = UID
        self.groups = []
    }
    
    func addUserDataToDB(events: [(Int, Int)]) async{
        
    }
    
    // Should return array of 1 item bc groupIds are unique
    func getGroupData(groupID: String) async throws -> Group {
        do {
            var groupData: Group = Group()
            
            let querySnapshot = try await db.collection("Groups").whereField("Document ID", isEqualTo: groupID)
                .getDocuments()
            for document in querySnapshot.documents {
                groupData = try document.data(as: Group.self)
            }
            
            return groupData
        } catch {
            print("Could not get group data of group: " + groupID)
            throw AuthenticationError.getGroupDataError
        }
    }
    
    //Should return array of 1 or more items
    func getAllGroupsUserIsIn() async throws -> [Group] {
        do {
            var groupsUserIsIn: [Group] = []
            
            let querySnapshot = try await db.collection("Groups").whereFilter(Filter.orFilter([
                Filter.whereField("User0", isEqualTo: self.UID),
                Filter.whereField("User1", isEqualTo: self.UID),
                Filter.whereField("User2", isEqualTo: self.UID),
                Filter.whereField("User3", isEqualTo: self.UID),
                Filter.whereField("User4", isEqualTo: self.UID),
                Filter.whereField("User5", isEqualTo: self.UID),
                Filter.whereField("User6", isEqualTo: self.UID),
                Filter.whereField("User7", isEqualTo: self.UID),
            ])).getDocuments()
            
            for document in querySnapshot.documents {
                let group = try document.data(as: Group.self)
                groupsUserIsIn.append(group)
            }
            
            return groupsUserIsIn
        } catch {
            throw AuthenticationError.getGroupsUserIsInError
        }
    }
    
    func createNewGroup() async throws
    
    func addUserDataToGroup(userData: [Int], groupID: String) async throws {
        
    }
}

struct User: Codable {
    var events: [Int]
}

struct Group: Codable {
    @DocumentID var id: String? = ""
    var NumOfUsers: Int = 0
    var User0: String = ""
    var User1: String = ""
    var User2: String = ""
    var User3: String = ""
    var User4: String = ""
    var User5: String = ""
    var User6: String = ""
    var User7: String = ""
    var Events: [Int] = []
}
