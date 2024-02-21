//
//  LoadingPage.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 2/21/24.
//

import SwiftUI

struct LoadingPage: View {
    //@EnvironmentObject var curUser: UserViewModel //creating first instance of environment variable
    @State var userAuthTokenExists: Bool = false
    @State var goHomePage: Bool = false
    @State var goWelcomePage: Bool = false
    var body: some View {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint:buttonColor))
                    .scaleEffect(CGSize(width: 2.0, height: 2.0))
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    if userAuthTokenExists {
                        goHomePage = true
                    } else {
                        //otherwise, we are going to get the auth token from the user by prompting them for phone number
                        print("nobody logged in, go to welcome page ")
                        goWelcomePage = true
                    }
                }
            }
            .navigationDestination(isPresented: $goHomePage){
                HomePage()
                    .navigationBarBackButtonHidden(true)

            }
            .navigationDestination(isPresented: $goWelcomePage){
                SignInPage()
                    .navigationBarBackButtonHidden(true)

            }
    }
    
}

#Preview {
    LoadingPage()
}
