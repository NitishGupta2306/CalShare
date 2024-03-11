import SwiftUI

struct NotificationsPage: View {
    var body: some View {
        NavigationStack {
                ZStack {
                    VStack {
                        Text("Notifications Page!")
                            .font(Font.custom("SeymourOne-Regular", size: 40))
                            .foregroundColor(Color("TextColor"))
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
    NotificationsPage()
}
