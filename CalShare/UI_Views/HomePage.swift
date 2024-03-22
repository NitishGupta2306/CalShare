import SwiftUI

struct HomePage: View {
    @State var firstFree = false
        @State var firstSlot: String = "No Available Time Slot"
    
    var body: some View {
        ZStack {
            VStack {
                CalenarContentView()
                Button {
                    print("Requested calendar access")
                    Task {
                        await CalendarViewModel.shared.requestAccess()
                        CalendarViewModel.shared.fetchCurrentWeekEvents()
                    }
                    Task{
                        try await DBViewModel.shared.updateCurrUserData()
                    }
                } label: {
                    Text("Push Your Weeks Events!")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .font(.custom(fontTwo, size: 20.0))
                        .bold()
                        .foregroundColor(Color("PastelBeige"))
                        .background(Color("PastelOrange"))
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                        .padding([.leading, .trailing], 20)
                        .padding(.bottom, 5)
                }
                
                //Displays the first free time slot
                Button {
                    firstSlot = CalendarViewModel.shared.getNextFreeTime()
                    print(firstSlot)
                    self.firstFree = true
                    
                } label: {
                    Text("Next Available Slot")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .font(.custom(fontTwo, size: 20.0))
                        .bold()
                        .foregroundColor(Color("PastelBeige"))
                        .background(Color("PastelOrange"))
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                        .padding([.leading, .trailing], 20)
                        .padding(.bottom, 5)
                }
                .alert(isPresented: $firstFree) {
                    Alert(
                        title: Text("Next Available Slot"),
                        message: Text("\(firstSlot)"),
                        dismissButton: .default(
                            Text("OK")
                                .foregroundColor(Color("PastelOrange"))
                        )
                    )
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

#Preview {
    HomePage()
}



