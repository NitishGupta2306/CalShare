//
//  SettingsView.swift
//  CalShare
//
//  Created by Nitish Gupta on 2/14/24.
//

import SwiftUI

@MainActor
final class SettingViewModel: ObservableObject{
    func logOut(){
        Task{
            do{
                try AuthenticationHandler.shared.signOut()
            }
            catch{
                print(AuthenticationError.signOutError)
            }
        }
    }
}

struct SettingsView: View {
    @StateObject private var viewModel = SettingViewModel()
    @Binding var isSignedIn: Bool

    var body: some View {
        List{
            Button{
                print("Clicked logout")
                viewModel.logOut()
                isSignedIn = false
                print(isSignedIn)
            } label: {
                Text("Logout")
            }
        }
        
        
    }
}

#Preview {
    SettingsView(isSignedIn: .constant(false))
}
