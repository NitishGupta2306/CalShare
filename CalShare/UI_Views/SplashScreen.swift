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
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                VStack {
                    Image("LogoImage")
                        .resizable()
                        .frame(width: 250, height: 250)
                    Text("CalShare")
                        .font(Font.custom("SeymourOne-Regular", size: 40))
                        .foregroundColor(Color("PastelOrange"))
                        .padding(.bottom, 20)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("PastelBeige"))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("LogoImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                }
                ToolbarItem(placement: .principal) {
                    Text("CalShare")
                        .foregroundStyle(Color("PastelOrange"))
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color("PastelBeige"))
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
}

#Preview {
    SplashScreen()
}
