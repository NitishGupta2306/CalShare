//
//  CreateCalendarPage.swift
//  CalShare
//
//  Created by Shubhada Martha on 2/27/24.
//

import SwiftUI

struct CreateCalendarPage: View {
    var body: some View {
        NavigationStack {
            //GeometryReader { _ in
                ZStack {
                    VStack {
                        Text("Create Calendar Page!")
                            .font(Font.custom("SeymourOne-Regular", size: 40))
                            .foregroundColor(textColor1)
                    }
                }
            //}
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("LogoImage")
                        .resizable()
                        .frame(width:60, height: 60)
                }
                ToolbarItem(placement: .principal) {
                    Text("CalShare").font(Font.custom("SeymourOne-Regular", size: 20))
                        .padding(.horizontal)
                        .foregroundColor(buttonColor)
                        .fontWeight(.bold)
                }
            }
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
    CreateCalendarPage()
}
