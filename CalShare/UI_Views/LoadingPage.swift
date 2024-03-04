import SwiftUI

// ROOT VIEW:
struct LoadingPage: View {
    @State var userAuthTokenExists: Bool = false
    @State var goContentViewPage: Bool = false
    @State var goSignInPage: Bool = false
    var body: some View {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint:buttonColor))
                    .scaleEffect(CGSize(width: 2.0, height: 2.0))
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    let authUser = try? AuthenticationHandler.shared.checkAuthenticatedUser()
                    userAuthTokenExists = authUser != nil
                    if userAuthTokenExists {
                        goContentViewPage = true
                    } else {
                        //otherwise, we are going to get the auth token from the user by prompting them for phone number
                        print("nobody logged in, go to welcome page ")
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
