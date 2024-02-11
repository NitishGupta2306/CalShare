//
//  ContentView.swift
//  CalShare
//
//  Created by Nitish Gupta on 1/19/24.
//

import SwiftUI

struct LandingPage: View {
    @StateObject var viewModel = ReadViewModel()
    
    var body: some View {
        VStack {
            let val = viewModel.value ?? ""
            Text(val)
            
            Button{
                viewModel.readVal()
            } label: {
                Text("Read")
                
            }
            
            Button{
                viewModel.writeVal()
            } label: {
                Text("Read")
                
            }
            
        }
    }
}

#Preview {
    LandingPage()
}
