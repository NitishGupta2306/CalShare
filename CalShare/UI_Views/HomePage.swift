import SwiftUI

struct HomePage: View {
    //@State var numMem: Int = 1
    @State var firstFree = false
        @State var firstSlot: String = "No Available Time Slot"
    
    var body: some View {
        ZStack {
            VStack {
                //                        HStack (alignment: .top){
                //                            Spacer()
                //                            Text("\(numMem)/7")
                //                                .font(.system(size: 30))
                //                                .bold()
                //                                .foregroundColor(Color("PastelOrange"))
                //                                .padding()
                //                        }
                
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
                    print("Displays the first free time slot")
                    firstSlot = CalendarViewModel.shared.getNextFreeTime()
                    print(firstSlot)
                    self.firstFree = true
                    
                } label: {
                    Text("First Available Slot")
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
                        title: Text("First Available Slot"),
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



