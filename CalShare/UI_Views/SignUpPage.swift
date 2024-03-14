import SwiftUI

@MainActor
final class SignUpPageViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws{
        try await AuthenticationHandler.shared.createrNewUser(email: email, pass: password)
    }
}

struct SignUpPage: View {
    @State var goContentViewPage: Bool = false
    @State var goLogInPage: Bool = false
    @State var errorMsg = ""
    
    @StateObject private var viewModel = SignUpPageViewModel()
    
    var body: some View {
//        NavigationStack {
            GeometryReader { _ in
                ZStack {
                    VStack(alignment: .center) {
                        Spacer()
                        Text("Register Now")
                            .font(.custom(fontTwo, size: 30.0))
                            .foregroundColor(Color("TextColor"))
                            .fontWeight(.semibold)
                            .padding()
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("E-mail Address")
                                .font(.custom(fontTwo, size: 14.0))
                                .foregroundColor(Color("PastelGray"))
                                .fontWeight(.regular)
                            
                            TextField("*****@gmail.com", text: $viewModel.email)
                                .foregroundColor(Color("PastelGray"))
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color("TextColor"), lineWidth: 0.5)
                                        .frame(height: 40)
                                )
                                .frame(width: 300)
                                .overlay(
                                    HStack {
                                        Image(systemName: "envelope")
                                            .foregroundColor(Color("PastelGray"))
                                            .padding(.leading, 10)
                                        
                                        Spacer() // Pushes the image and text to the leading edge
                                    }
                                )
                                .ignoresSafeArea(.keyboard)
                                .padding()
                                .multilineTextAlignment(.center) // Center-align the entered text
                            
                            Text("Password")
                                .font(.custom(fontTwo, size: 14.0))
                                .foregroundColor(Color("PastelGray"))
                                .fontWeight(.regular)
                            
                            
                            SecureField("**********", text: $viewModel.password)
                                .foregroundColor(Color("PastelGray"))
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color("TextColor"), lineWidth: 0.5)
                                        .frame(height: 40)
                                )
                                .frame(width: 300)
                                .overlay(
                                    HStack {
                                        Image(systemName: "lock")
                                            .foregroundColor(Color("PastelGray"))
                                            .padding(.leading, 10)
                                        
                                        Spacer() // Pushes the image and text to the leading edge
                                    }
                                )
                                .ignoresSafeArea(.keyboard)
                                .multilineTextAlignment(.center) // Center-align the entered text
                                .padding()
                            
                            Text(errorMsg)
                                .font(.custom(fontTwo, size: 14.0))
                                .foregroundColor(Color.red)
                                .fontWeight(.regular)
                        }
                        
                        Button {
                            self.goLogInPage.toggle()
                        } label: {
                            Text("Already have an account?")
                                .foregroundColor(Color("TextColor"))
                        }
                        
                        // SIGN UP BUTTON
                        Button ("Get Started") {
                            Task{
                                do{
                                    try await viewModel.signUp()
                                    self.goContentViewPage.toggle()
                                } catch {
                                    errorMsg = "Email used or Password not long enough"
                                    throw AuthenticationError.signUpError
                                }

                            }
                            // Dismisses the keyboard when the "Send Code" button is tapped
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        .padding(.horizontal, 120)
                        .padding(.vertical, 20)
                        .background(Color("PastelOrange"))
                        .foregroundColor(Color("PastelBeige"))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .frame(width: 400, height: 100)
                        Spacer()
                    }
                }
            }
            .onChange(of: goContentViewPage, {
                print("Requested calendar access")
                Task {
                  await CalendarViewModel.shared.requestAccess()
                }
            })
            .navigationDestination(isPresented: $goContentViewPage) {
                ContentViewPage()
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $goLogInPage) {
                SignInPage()
                    .navigationBarBackButtonHidden()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("LogoImage")
                        .resizable()
                        .frame(width:60, height: 60)
                }
                ToolbarItem(placement: .principal) {
                    Image("CalShare")
                        .resizable()
                        .frame(width: 130, height: 20)
                }
            }
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("PastelBeige"))
//        }
        .onTapGesture {
            //Dismisses the keyboard if you click away
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    SignUpPage()
}
