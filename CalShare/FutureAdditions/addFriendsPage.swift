import SwiftUI

struct addFriendsPage: View {
    @State var cancel: Bool = false
    @State var addedFriend: Bool = false
    
    var body: some View {
        NavigationStack {
                ZStack {
                    VStack {
                        Text("Add Friends Page!")
                            .font(Font.custom("fontTwo", size: 40))
                        .foregroundColor(Color("TextColor"))
                        
                        HStack {
                            Button ("Add Friend") {
                                //print("We are getting a new User and setting their information")
                                self.addedFriend.toggle()
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(Color("PastelOrange"))
                            .foregroundColor(Color("PastelBeige"))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            .frame(width: 150, height: 50)
                            
                            Button ("Cancel") {
                                //print("We are getting a new User and setting their information")
                                self.cancel.toggle()
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(Color("PastelOrange"))
                            .foregroundColor(Color("PastelBeige"))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            .frame(width: 150, height: 50)
                        }
                    }
                }
                .navigationDestination(isPresented: $cancel) {
                    GroupCreationPage()
                        .navigationBarBackButtonHidden()
                }
                .navigationDestination(isPresented: $addedFriend) {
                    GroupCreationPage()
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
    addFriendsPage()
}

