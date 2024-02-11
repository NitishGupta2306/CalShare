//
//  ReadViewModel.swift
//  CalShare
//
//  Created by Nitish Gupta on 2/8/24.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class ReadViewModel: ObservableObject {
    @Published var value: String?
    var ref = Database.database().reference()
    
    func readVal(){        
        ref.child("KeyA").observeSingleEvent(of: .value){ snapshot in
            self.value = snapshot.value as? String
            
        }
    }
}
