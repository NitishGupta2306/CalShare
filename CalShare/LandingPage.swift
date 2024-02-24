//
//  ContentView.swift
//  CalShare
//
//  Created by Nitish Gupta on 1/19/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LandingPage: View {
    var body: some View {
        VStack{
            GoogleSignInButton(action: handleSignInButton)
        }
    }
}
func handleSignInButton() {
    guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
        print("Failed to get presentingViewController")
        return
    }
    let calendarScope = ["https://www.googleapis.com/auth/calendar.readonly"]
    GIDSignIn.sharedInstance.signIn(
        withPresenting: presentingViewController) { signInResult, error in
            guard let result = signInResult else {
                // Inspect error
                print("Result Error")
                return
            }
            guard let user = signInResult?.user else {return}
            let emailAddress: String = user.profile?.email ?? ""
            print(emailAddress)
            
            // Add calendar scope
            guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
                print("Failed to get presentingViewController")
                return
            }
            user.addScopes(calendarScope, presenting: presentingViewController) { signInResult, error in
                guard error == nil else { return }
                guard let signInResult = signInResult else { return }
                
            }
            let grantedScopes = user.grantedScopes
            if grantedScopes == nil || !grantedScopes!.contains("https://www.googleapis.com/auth/calendar.readonly") {
                print("No access to calendar")
                return
            }
            print("HAS ACCESS TO CALENDAR")
            
     }
}

#Preview {
    LandingPage()
}
