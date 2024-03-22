import SwiftUI

struct GroupsPage: View {
    @State var usersGroupsID : [String] = []
    @State var usersInGroupCalData: [Double] = []
    @State var numberGroups: Int = 0
    
    @State var dataLoaded: Bool = false
    
    @State var displayGroupQrPage: Bool = false
    @State var selectedGroupID: String = ""
    
    var body: some View {
        ZStack {
            VStack{
                VStack(alignment: .leading, spacing: 5){
                    if !usersGroupsID.isEmpty {
                        List{
                            ForEach(1...numberGroups, id: \.self){ index in
                                Button{
                                    Task{
                                        displayGroupQrPage = true
                                        selectedGroupID = usersGroupsID[index-1]
                                        
                                        usersInGroupCalData =
                                        try await DBViewModel.shared
                                            .getUserDataFromUsersInGroup(groupID: usersGroupsID[index-1])
                                        
                                        CalendarViewModel.shared
                                            .createFreeTimeSlotEvents(startEndTimes: usersInGroupCalData)
                                        dataLoaded = true
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
                NavigationLink(destination: DisplayGroupQrPage(groupID: selectedGroupID), isActive: $displayGroupQrPage){}
            }
        }
        .ignoresSafeArea(.keyboard)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: {
            Task{
                let usersGroups = try await DBViewModel.shared.getAllGroupsUserIsIn()
                for group in usersGroups{
                    
                    let GID = group.id ?? ""
                    
                    if !usersGroupsID.contains(GID){
                        usersGroupsID.append(GID)
                    }
                }
                numberGroups = usersGroupsID.count
            }
        })
    }
}

#Preview {
    GroupsPage()
}


