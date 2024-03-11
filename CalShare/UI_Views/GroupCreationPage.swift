import CoreImage
import CodeScanner
import CoreImage.CIFilterBuiltins

import SwiftUI

struct GroupCreationPage: View {
    @State private var gotQR = false
    @State private var scanQR = false
    @State private var generatedQRImage: UIImage?
    @State private var scannedString: String?
    @State private var generatedQR: String?
    @State var addCal: Bool = false
    @State var addFriend: Bool = false
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
                ZStack {
                    VStack {
                        Spacer()
                        Text("Create or Join New Group!")
                            .font(.custom(fontTwo, size: 30.0))
                            .foregroundColor(Color("PastelGray"))
                            .fontWeight(.regular)
                        
                        Spacer()
                        
                        if let generatedQRImage = generatedQRImage {
                            Image(uiImage: generatedQRImage)
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        }
                        
                        //Generates and pushes a new group to DB
                        Button(action: {
                            print("Generate QR")
                            Task {
                                do {
                                    let generatedQR = try await DBViewModel.shared.createNewGroupAndAddCurrUser()
                                    self.generatedQRImage = generateQRCode(from: "\(generatedQR)")
                                    self.generatedQR = generatedQR
                                } catch {
                                    // Handle error
                                    print("Error: \(error)")
                                }
                            }
                            
                        }) {
                            HStack {
                                Text("Generate QR")
                                    .foregroundColor(Color("PastelBeige"))
                                
                                Image(systemName: "qrcode")
                                    .foregroundColor(Color("PastelBeige"))
                                    .padding(.leading, 10)
                                    .font(.system(size: 30))
                            }
                            .padding(.horizontal, 100)
                            .padding(.vertical, 20)
                            .background(Color("PastelOrange"))
                            .foregroundColor(Color("PastelBeige"))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            .frame(width: 400, height: 100)
                        }
                        
                        // Access Camera and allows currUser to join group linked to QRCode.
                        Button(action: {
                            print("Scan QR")
                            self.scanQR.toggle()
                        }) {
                            HStack {
                                Text("Scan QR")
                                    .foregroundColor(Color("PastelBeige"))
                                
                                Image(systemName: "qrcode")
                                    .foregroundColor(Color("PastelBeige"))
                                    .padding(.leading, 10)
                                    .font(.system(size: 30))
                            }
                            .padding(.horizontal, 100)
                            .padding(.vertical, 20)
                            .background(Color("PastelOrange"))
                            .foregroundColor(Color("PastelBeige"))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            .frame(width: 400, height: 100)
                        }
                        
                        if gotQR {
                            Text("Got QR")
                                .onAppear {
                                    Task {
                                        if let scannedString = scannedString{
                                            try await DBViewModel.shared.addUserToGroup(groupID: scannedString)
                                        }
                                        scanQR = false
                                    }
                                }
                        }
                        
                        Spacer()
                    }
                }
                .navigationDestination(isPresented: $addCal) {
                    CreateCalendarPage()
                        .navigationBarBackButtonHidden()
                }
                .navigationDestination(isPresented: $addFriend) {
                    addFriendsPage()
                        .navigationBarBackButtonHidden()
                }
                .sheet(isPresented: $scanQR) {
                    CodeScannerView(codeTypes: [.qr]) { response in
                        if case let .success(result) = response {
                            scannedString = result.string
                            print(scannedString ?? "Error while scanning QR code.")
                        }
                        gotQR = true
                        scanQR = false
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
    GroupCreationPage()
}
