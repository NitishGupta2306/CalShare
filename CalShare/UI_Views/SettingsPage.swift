import SwiftUI

@MainActor
final class SettingViewModel: ObservableObject{
    var email = ""
    var password = ""
    var errMsg = ""
    
    func logOut(){
        Task{
            do{
                try AuthenticationHandler.shared.signOut()
            }
            catch{
                throw AuthenticationError.signOutError
            }
        }
    }
    
    func resetPass() async throws {
        let currentUser = try AuthenticationHandler.shared.checkAuthenticatedUser()
        
        guard let email = currentUser.email else {
            throw AuthenticationError.getUserFail
        }
        
        do{
            try await AuthenticationHandler.shared.passReset(email: email)
        } catch {
            throw AuthenticationError.passResetError
        }
    }
    
    func updatePass() async throws{
        if(self.password.count > 7){
            try await AuthenticationHandler.shared.updatePass(password: self.password)
        }
        else{
            self.errMsg = "Not a valid password."
        }
    }
}

struct SettingsPage: View {
    @StateObject private var viewModel = SettingViewModel()
    @ObservedObject private var calendarViewModel = CalendarViewModel.shared
    @State var isSignedOut: Bool = false
    
    var body: some View {
            ZStack{
                VStack{
                    VStack(alignment: .leading, spacing: 5) {
                        List{
                            Button{
                                viewModel.logOut()
                                isSignedOut.toggle()
                            }label: {
                                Text("Logout")
                            }
                            
                            Button{
                                Task{
                                    try await viewModel.resetPass()
                                }
                            }label: {
                                Text("Reset Password")
                            }
                            Toggle(isOn: $calendarViewModel.isBusinessHours){
                                Text(calendarViewModel.isBusinessHours ? "Business Hours" : "All Hours")
                            }
                            .onChange(of: calendarViewModel.isBusinessHours) {
                                if calendarViewModel.isBusinessHours {
                                    calendarViewModel.noEarlierThan = 9
                                    calendarViewModel.noLaterThan = 17
                                } else {
                                    calendarViewModel.noEarlierThan = 0
                                    calendarViewModel.noLaterThan = 24
                                }
                            }
                        }
                    }
                }
            .navigationDestination(isPresented: $isSignedOut) {
                SignInPage()
                    .navigationBarBackButtonHidden()
            }
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    SettingsPage()
}
