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
        FirebaseApp.configure()
        self.db = Firestore.firestore()
        self.UID = UID
        self.groups = []
    }
    
    func addUserDataToDB(events: [(Int, Int)]) async{
        
    }
    
    // Should return array of 1 item bc groupIds are unique
    func getGroupData(groupID: String) -> [Group] {
        @FirestoreQuery(
            collectionPath: "Groups",
            predicates: [.where("Document ID", isEqualTo: groupID)]
        ) var groupData: [Group]
        return groupData
    }
    
    //Should return array of 1 or more items
    func getAllGroupsUserIsIn() -> [Group] {
        @FirestoreQuery(
            collectionPath: "Groups"
            predicates: [.where(Filter.or(
                Filter.equalTo("User0", self.UID),
                Filter.equalTo("User1", self.UID),
                Filter.equalTo("User2", self.UID),
                Filter.equalTo("User3", self.UID),
                Filter.equalTo("User4", self.UID),
                Filter.equalTo("User5", self.UID),
                Filter.equalTo("User6", self.UID),
                Filter.equalTo("User7", self.UID)
                )]
        ) var allGroupsUserIsIn: [Group]
    }
}

struct User: Codable {
    var events: [Int]
}

struct Group: Codable {
    var NumOfUsers: Int
    var User0: String
    var User1: String
    var User2: String
    var User3: String
    var User4: String
    var User5: String
    var User6: String
    var User7: String
    var Events: [Int]
}
