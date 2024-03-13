import CoreImage
import CodeScanner
import CoreImage.CIFilterBuiltins

import SwiftUI

struct DisplayCodePage: View {
    @State var firstFree = false
    @State var goHome = false
    @State private var generatedQRImage: UIImage?
    @State private var generatedQR: String?
    @State var firstSlot: String = "Tuesday March 22nd 2:00 - 3:00PM"
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    @State private var test = "TestValue"
    
    var body: some View {
        NavigationStack {
                ZStack {
                    VStack {
                        Text("Display QR Code")
                        
                        if let generatedQRImage = generatedQRImage {
                            Image(uiImage: generatedQRImage)
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        }
                        
                        //Displays the first free time slot
                        Button(action: {
                            print("Displays the first free time slot")
                            firstFree = true
                            
                            //Display popup
                            
                        }) {
                            HStack {
                                Text("First Available Slot")
                                    .foregroundColor(Color("PastelBeige"))
                            }
                            .padding(.horizontal, 100)
                            .padding(.vertical, 20)
                            .background(Color("PastelOrange"))
                            .foregroundColor(Color("PastelBeige"))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            .frame(width: 400, height: 100)
                        }
                        
                        //Displays the home page
//                        Button(action: {
//                            print("Displays the Home Page")
//                            goHome = true
//                        }) {
//                            HStack {
//                                Text("All Available Slots")
//                                    .foregroundColor(Color("PastelBeige"))
//                            }
//                            .padding(.horizontal, 100)
//                            .padding(.vertical, 20)
//                            .background(Color("PastelOrange"))
//                            .foregroundColor(Color("PastelBeige"))
//                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
//                            .frame(width: 400, height: 100)
//                        }
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
                    do {
                        let generatedQR = try await DBViewModel.shared.createNewGroupAndAddCurrUser()
                        self.generatedQRImage = generateQRCode(from: "\(generatedQR)")
//                        self.generatedQRImage = generateQRCode(from: "\(test)")
                        self.generatedQR = generatedQR
                    } catch {
                        // Handle error
                        print("Error: \(error)")
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
                .navigationDestination(isPresented: $goHome) {
                    HomePage()
                        .navigationBarBackButtonHidden()
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
    DisplayCodePage()
}
