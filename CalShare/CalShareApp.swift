//
//  CalShareApp.swift
//  CalShare
//
//  Created by Nitish Gupta on 1/19/24.
//

import SwiftUI
import FirebaseCore

let backgroundColor = Color(red: 255/255, green: 252/255, blue: 246/255)
let buttonColor = Color(red: 255/255, green: 207/255, blue: 134/255)
let textColor1 = Color(red: 101/255, green: 96/255, blue: 96/255)

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct CalShareApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject var curUser = UserModel()
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        SplashScreen()
      }
    }
    .environmentObject(curUser)
  }
}

