import SwiftUI

struct GroupsPage: View {
    @State var usersGroupsID : [String] = []
    @State var usersInGroupCalData: [Double] = []
    @State var numberGroups: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    VStack(alignment: .leading, spacing: 5){
                        if !usersGroupsID.isEmpty {
                            List{
                                ForEach(1...numberGroups, id: \.self){ index in
                                    Button{
                                        Task{
                                            usersInGroupCalData = try await DBViewModel.shared.getUserDataFromUsersInGroup(groupID: usersGroupsID[index-1])

                                            // ADD TOGGLE TO MOVE TO CALENDAR VIEW AND SHOW THE FINAL CAL
                                        }
                                    }
                                    label: {
                                        Text("Group" + String(index))
                                            .foregroundColor(Color("TextColor"))
                                            .listRowBackground(Color("PastelBeige"))
                                    }
                                }
                            }
                        } else {
                            Text("No Groups Currently Added.")
                                .font(Font.custom("SeymourOne-Regular", size: 40))
                                .foregroundColor(Color("TextColor"))
                        }
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear(perform: {
                if usersGroupsID.isEmpty{
                    Task{
                        let usersGroups = try await DBViewModel.shared.getAllGroupsUserIsIn()
                        for group in usersGroups{
                            usersGroupsID.append(group.id ?? "")
                        }
                        numberGroups = usersGroupsID.count
                    }
                }
            })
        }
    }
}

#Preview {
    GroupsPage()
}


