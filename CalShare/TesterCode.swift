//
//  TesterCode.swift
//  CalShare
//
//  Created by Nitish Gupta on 2/13/24.
//

// This file is purely for testCode.
// This file should only be executed on direct change by developer.
// Please enter all location where this file may be called.
// MUST BE REMOVED BEFORE DEPLOYMENT.

// Current call locations: None.

import Foundation
import SwiftUI

struct TestReadWrite: View {
    var body: some View {
        @StateObject var readViewModel = ReadViewModel()
        @StateObject var writeViewModel = WriteViewModel()
        
        VStack {
            let readOutput = readViewModel.value ?? ""
            
            // Change before testing read/write.
            let key = ""
            let value = ""
            
            Text(readOutput)
            // Read call
            Button{
                readViewModel.readVal(key: key)
            } label: {
                Text("Read")
            }
            // Write call
            Button{
                writeViewModel.writeVal(key: key, value: value)
            } label: {
                Text("write")
            }
            
        }
    }
}
