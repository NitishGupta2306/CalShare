import SwiftUI

struct LoadingPage: View {
    @State var userAuthTokenExists: Bool = false
    @State var goContentViewPage: Bool = false
    @State var goSignInPage: Bool = false
    var body: some View {
            ZStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint:buttonColor))
                    .scaleEffect(CGSize(width: 2.0, height: 2.0))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color("PastelBeige"))
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    CalendarViewModel.shared.fetchCurrentWeekEvents()
                    
                    let authUser = try? AuthenticationHandler.shared.checkAuthenticatedUser()
                    userAuthTokenExists = authUser != nil
                    if userAuthTokenExists {
                        goContentViewPage = true
                    } else {
                        goSignInPage = true
                    }
                }
            }
            .navigationDestination(isPresented: $goContentViewPage){
                ContentViewPage()
                    .navigationBarBackButtonHidden(true)

            }
            .navigationDestination(isPresented: $goSignInPage){
                SignInPage()
                    .navigationBarBackButtonHidden(true)

            }
    }
    
}

#Preview {
    LoadingPage()
}
