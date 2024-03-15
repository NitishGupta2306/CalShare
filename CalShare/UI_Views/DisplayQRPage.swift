import CoreImage
import CodeScanner
import CoreImage.CIFilterBuiltins

import SwiftUI

struct DisplayQrPage: View {
    @State var firstFree = false
    @State var goHome = false
    @State private var generatedQRImage: UIImage?
    @State private var generatedQR: String?
    @State var firstSlot: String = "No Available Time Slot"
    @State var numMem: Int = 1
    @State private var isFirstLoad = true
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    @State private var test = "TestValue"
    
    var body: some View {
                ZStack {
                    VStack {
                        HStack (alignment: .top){
                            Spacer()
                            Text("\(numMem)/7")
                                .font(.system(size: 35))
                                .bold()
                                .foregroundColor(Color("PastelOrange"))
                                .padding(30)
                        }
                        
                        Spacer()
                        
                        ZStack {
                            if let generatedQRImage = generatedQRImage {
                                Image(uiImage: generatedQRImage)
                                    .resizable()
                                    .interpolation(.none)
                                    .scaledToFit()
                                    .frame(width: 250, height: 250)
                            }
                        }
                        Spacer()
                        
                        VStack {
                            //Displays the first free time slot
                            Button(action: {
                                print("Displays the first free time slot")
                                firstSlot = CalendarViewModel.shared.getNextFreeTime()
                                print(firstSlot)
                                
                                self.firstFree = true
                                
                            }) {
                                HStack {
                                    Text("First Available Slot")
                                        .foregroundColor(Color("PastelBeige"))
                                        .font(.custom(fontTwo, size: 20.0))
                                        .bold()
                                }
                                .padding(.horizontal, 88)
                                .padding(.vertical, 20)
                                .background(Color("PastelOrange"))
                                .foregroundColor(Color("PastelBeige"))
                                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                .frame(width: 348, height: 80)
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
                            
                            //Displays the home page
                            Button(action: {
                                Task{
                                    let usersInGroupCalData =
                                    try await DBViewModel.shared
                                        .getUserDataFromUsersInGroup(groupID: generatedQR ?? "")
                                    CalendarViewModel.shared
                                        .createFreeTimeSlotEvents(startEndTimes: usersInGroupCalData)
                                }
                                self.goHome = true
                            }) {
                                HStack {
                                    Text("All Available Slots")
                                        .foregroundColor(Color("PastelBeige"))
                                        .font(.custom(fontTwo, size: 20.0))
                                        .bold()
                                }
                                .padding(.horizontal, 90)
                                .padding(.vertical, 20)
                                .background(Color("PastelOrange"))
                                .foregroundColor(Color("PastelBeige"))
                                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                .frame(width: 350, height: 80)
                            }
                            //                            .padding(20)
                        }
                        
                        NavigationLink(destination: HomePage(), isActive: $goHome){}
                        
                        Spacer()
                        
                    }
                }
                .onTapGesture {
                    //Dismisses the keyboard if you click away
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .ignoresSafeArea(.keyboard)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("PastelBeige"))
                .task {
                    if isFirstLoad {
                        do {
                            let generatedQR = try await DBViewModel.shared.createNewGroupAndAddCurrUser()
                            self.generatedQRImage = generateQRCode(from: "\(generatedQR)")
                            //                        self.generatedQRImage = generateQRCode(from: "\(test)")
                            self.generatedQR = generatedQR
                            isFirstLoad = false // Update the flag
                        } catch {
                            // Handle error
                            print("Error: \(error)")
                        }
                    }
                }
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
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        print("Error: couldn't generateQRCode")
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
      
}

#Preview {
    DisplayQrPage()
}
