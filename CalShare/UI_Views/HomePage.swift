//
//  HomePage.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 2/20/24.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationStack {
            //GeometryReader { _ in
                ZStack {
                    VStack {
                        Text("Landing Page!")
                            .font(.custom(fontTwo, size: 40))
                            .foregroundColor(Color("TextColor"))
                    }
                }
            //}
            .onTapGesture {
                //Dismisses the keyboard if you click away
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("PastelBeige"))
        }
    }
}

#Preview {
    HomePage()
}
