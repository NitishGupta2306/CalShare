//
//  WriteViewModel.swift
//  CalShare
//
//  Created by Nitish Gupta on 2/8/24.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class WriteViewModel: ObservableObject {
    @Published var value: String?
    var ref = Database.database().reference()
    
    func writeVal(key: String, value: String){
        ref.child(key).setValue(value)
    }
    
}
