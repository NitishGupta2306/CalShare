//
//  HomePage.swift
//  CalShare
//
//  Created by Chitra Mukherjee on 2/20/24.
//

import SwiftUI

struct HomePage: View {
  @StateObject var calendar = CalendarViewModel()
  
  var body: some View {
    NavigationStack {
      //GeometryReader { _ in
      ZStack {
        VStack {
          
          EventListView()
          
          Spacer()
          
          Text("Landing Page!")
            .font(Font.custom("SeymourOne-Regular", size: 40))
            .foregroundColor(textColor1)
          
          Button {
            
            Task {
              await calendar.requestAccess()
            }
            
          } label: {
            Text("Request Calendar Data Access")
              .frame(maxWidth: .infinity)
              .frame(height: 40)
              .font(.system(size: 20))
              .foregroundColor(.black)
              .background(.green)
              .clipShape(RoundedRectangle(cornerRadius: 5.0))
              .padding([.leading, .trailing], 20)
          }
          
          Button {
            
            calendar.fetchCurrentWeekEvents()
            
          } label: {
            Text("Request Calendar Data")
              .frame(maxWidth: .infinity)
              .frame(height: 40)
              .font(.system(size: 20))
              .foregroundColor(.black)
              .background(.green)
              .clipShape(RoundedRectangle(cornerRadius: 5.0))
              .padding([.leading, .trailing], 20)
          }
          
          Spacer()
          
        }
      }
      //}
      .onTapGesture {
        //Dismisses the keyboard if you click away
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
      .ignoresSafeArea(.keyboard)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
//      .edgesIgnoringSafeArea(.all)
      .background(Color("PastelBeige"))
    }
    .environmentObject(calendar)

  }
}

#Preview {
    HomePage()
}
