//
//  ContentViewPage.swift
//  CalShare
//
//  Created by Shubhada Martha on 2/27/24.
//

import SwiftUI

struct ContentViewPage: View {
    @State var currentTab = 0
    
    var body: some View {
        TabView (selection: $currentTab) {
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color("PastelOrange"))
                }
                .tag(0)
            
            CreateViewGroupsPage()
                .tabItem {
                    Image(systemName: "person.3.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color("PastelOrange"))
                }
                .tag(1)
            
            NotificationsPage()
                .tabItem {
                    Image(systemName: "bell.badge.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color("PastelOrange"))
                }
                .tag(2)
            
            SettingsPage()
                .tabItem {
                    Image(systemName: "gear")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color("PastelOrange"))
                }
                .tag(3)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image("LogoImage")
                    .resizable()
                    .frame(width:60, height: 60)
            }
            ToolbarItem(placement: .principal) {
//                    Text("CalShare")
//                        .foregroundStyle(Color("PastelOrange"))
                Image("CalShare")
                    .resizable()
                    .frame(width: 130, height: 20)
            }
        }
    }
}

#Preview {
    ContentViewPage()
}

