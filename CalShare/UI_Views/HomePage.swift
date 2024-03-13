import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationStack {
                ZStack {
                    VStack {
                        CalenarContentView()
                        Button {
                            CalendarViewModel.shared.fetchCurrentWeekEvents()
                            Task{
                                try await DBViewModel.shared.updateCurrUserData()
                            }
                        } label: {
                            Text("Push Your Weeks Events!")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .background(Color("PastelOrange"))
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                .padding([.leading, .trailing], 20)
                                .padding(.bottom, 5)
                        }
                        
                        Button {
                            print(CalendarViewModel.shared.getNextFreeTime())
                        } label: {
                            Text("Get Free Time!")
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .background(Color("PastelOrange"))
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                .padding([.leading, .trailing], 20)
                                .padding(.bottom, 50)
                        }
                    }
                }
                .onTapGesture {
                    //Dismisses the keyboard if you click away
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .ignoresSafeArea(.keyboard)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("PastelBeige"))
        }
      
    }
      
}

#Preview {
    HomePage()
}



