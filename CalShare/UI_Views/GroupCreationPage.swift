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
//        NavigationStack {
                ZStack {
                    VStack (alignment: .leading) {
                        Spacer()
                        
//                        Image(systemName: "person.3.fill")
//                            .foregroundColor(Color("PastelOrange"))
//                            //.padding(.leading, 15)
//                            .font(.system(size: 190))
                        
                        //VStack (alignment: .leading, spacing: 10) {
                            Text("Create New Group!")
                                .font(.custom(fontTwo, size: 20.0))
                                .foregroundColor(Color("PastelGray"))
                                .fontWeight(.regular)
                                .padding(20)
                            
                            
                            ZStack {
                                //Goes to DisplayCodePage
                                Button(action: {
                                    print("Generate QR")
                                    genQR = true
                                    
                                }) {
                                    HStack {
                                        Text("Generate")
                                            .font(.custom(fontTwo, size: 20.0))
                                            .foregroundColor(Color("PastelBeige"))
                                            .bold()
                                        
                                        Image(systemName: "qrcode")
                                            .foregroundColor(Color("PastelBeige"))
                                            .padding(.leading, 10)
                                            .font(.system(size: 75))
                                    }
                                    .padding(.horizontal, 70)
                                    .padding(.vertical, 20)
                                    .background(Color("PastelOrange"))
                                    .foregroundColor(Color("PastelBeige"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                    .frame(width: 350, height: 80)
                                }
                            }.padding(20)
                        
                            NavigationLink(destination: DisplayQrPage(), isActive: $genQR){}
                            
                            Text("Join New Group!")
                                .font(.custom(fontTwo, size: 20.0))
                                .foregroundColor(Color("PastelGray"))
                                .fontWeight(.regular)
                                .padding(20)
                            
                            ZStack {
                                // Access Camera and allows currUser to join group linked to QRCode.
                                Button(action: {
                                    print("Scan")
                                    self.scanQR.toggle()
                                }) {
                                    HStack {
                                        Text("Scan QR")
                                            .font(.custom(fontTwo, size: 20.0))
                                            .foregroundColor(Color("PastelBeige"))
                                            .bold()
                                        
                                        Image(systemName: "qrcode.viewfinder")
                                            .foregroundColor(Color("PastelBeige"))
                                            .padding(.leading, 10)
                                            .font(.system(size: 75))
                                    }
                                    .padding(.horizontal, 70) //100
                                    .padding(.vertical, 20)
                                    .background(Color("PastelOrange"))
                                    .foregroundColor(Color("PastelBeige"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                    .frame(width: 350, height: 80)
                                }
                            }.padding(20)
                        //}
                        
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
//                .navigationDestination(isPresented: $genQR) {
//                    DisplayQrPage()
////                        .navigationBarBackButtonHidden()
//                }
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
//    }
}

#Preview {
    GroupCreationPage()
}
