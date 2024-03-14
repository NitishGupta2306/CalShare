import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false

    var body: some View {
//        NavigationStack {
            ZStack {
                VStack {
                    Image("LogoImage")
                        .resizable()
                        .frame(width: 240, height: 253)
                    Image("CalShare")
                        .resizable()
                        .frame(width: 270, height: 40)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("PastelBeige"))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive.toggle()
                    }
                }
            }
            .navigationDestination(isPresented: $isActive) {
                LoadingPage()
                    .navigationBarBackButtonHidden(true)
            }
        }
//    }
}

#Preview {
    SplashScreen()
}
