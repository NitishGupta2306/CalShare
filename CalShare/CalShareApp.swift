//
//  CalShareApp.swift
//  CalShare
//
//  Created by Nitish Gupta on 1/19/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import GoogleSignInSwift


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   open url: URL,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
    // Google Sign In
    GIDSignIn.sharedInstance.handle(url)
    //GIDSignIn.sharedInstance().clientID = "500712914827-4qhbo858nts7n7k8f0iqlsd347480hq5.apps.googleusercontent.com"

    return true
  }
}

@main
struct CalShareApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    

  var body: some Scene {
    WindowGroup {
      NavigationStack {
        LandingPage()
      }
    }
  }
}
