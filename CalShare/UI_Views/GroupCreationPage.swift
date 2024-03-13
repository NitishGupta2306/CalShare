import CoreImage
import CodeScanner
import CoreImage.CIFilterBuiltins

import SwiftUI

struct GroupCreationPage: View {
    @State private var gotQR = false
    @State private var scanQR = false
    @State private var scannedString: String?
    @State var genQR: Bool = false
    
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
                        
                        //Goes to DisplayCodePage
                        Button(action: {
                            print("Generate QR")
                            genQR = true
                            
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
                .navigationDestination(isPresented: $genQR) {
                    //DisplayCodePage()
//                        .navigationBarBackButtonHidden()
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
}

#Preview {
    GroupCreationPage()
}
