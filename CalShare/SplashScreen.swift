//
//  SplashScreen.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 2/20/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false

    var body: some View {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                VStack {
                    Image("LogoImage")
                        .resizable()
                        .frame(width: 250, height: 250)
                    Text("CalShare")
                        .font(Font.custom("Seymour", size: 40))
                        .foregroundColor(buttonColor)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                }
            }
            .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive.toggle()
                        }
                    }
                }
            .navigationDestination(isPresented: $isActive) {
                    LoadingPage()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }

#Preview {
    SplashScreen()
}
