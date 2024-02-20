//
//  ContentView.swift
//  CalShare
//
//  Created by Nitish Gupta on 1/19/24.
//

import SwiftUI

struct LandingPage: View {
  @EnvironmentObject var user: UserModel
  
    var body: some View {
        ZStack{
            Color(.white)
                .ignoresSafeArea()
            
            VStack{
                Text("You are on the landing page.")
                  .foregroundStyle(.black)
            }
            
        }
    }
}

#Preview {
    LandingPage()
    .environmentObject(UserModel())
}
