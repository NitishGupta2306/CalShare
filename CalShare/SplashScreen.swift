//
//  SplashScreen.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 2/20/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.3
    let background = Color(red: 255, green: 252, blue: 246)
    let buttonColor = Color(red: 255, green: 207, blue: 134)

    var body: some View {
        if isActive {
            LandingPage()
        } else {
            ZStack {
                Rectangle()
                    .background(background)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
