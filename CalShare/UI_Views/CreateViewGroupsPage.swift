//
//  CreateViewGroupsPage.swift
//  CalShare
//
//  Created by Shubhada Martha on 2/27/24.
//

import CoreImage
import CodeScanner
import CoreImage.CIFilterBuiltins

import SwiftUI

struct CreateViewGroupsPage: View {
    @State var addCal: Bool = false
    @State var addFriend: Bool = false
    @State private var gotQR = false
    @State private var scanQR = false
    @State private var generatedQRImage: UIImage?
//    let testString = "testString00123"
//    let testScannedString = "testString00123"
    @State private var scannedString: String?
    @State private var generatedQR: String?
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            //GeometryReader { _ in
                ZStack {
                    VStack {
                        Spacer()
                        Text("Calendars")
                            .font(.custom(fontTwo, size: 30.0))
                            .foregroundColor(Color("PastelGray"))
                            .fontWeight(.regular)
                        
                        HStack { //WILL NEED TO CHANGE THIS to take the groups and put them here
                            Image(systemName: "person.3.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Color("PastelOrange"))
                                .padding(.leading, 10)
                            
                            Image(systemName: "person.3.fill")
                                .foregroundColor(Color("PastelOrange"))
                                .padding(.leading, 10)
                                .font(.system(size: 30))
                            
                            Image(systemName: "person.3.fill")
                                .foregroundColor(Color("PastelOrange"))
                                .padding(.leading, 10)
                                .font(.system(size: 30))
                            
                            Button {
                                print("Add Calendar")
                                self.addCal.toggle()
                            } label: {
                                Image(systemName: "calendar.badge.plus")
                                    .foregroundColor(Color("PastelOrange"))
                                    .padding(.leading, 10)
                                    .font(.system(size: 30))
                            }
                            
                        }
                        .padding()
                        
                        Text("Scan QR to add group")
                            .font(.custom(fontTwo, size: 30.0))
                            .foregroundColor(Color("PastelGray"))
                            .fontWeight(.regular)
                        
                        
                        //GENERATES A NEW GROUP ID EVERY SINGLE TIME THIS BUTTON IS PRESSED
                        Button(action: {
                            print("Generate QR")
//                            self.generateQR.toggle()
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

                        
                        if let generatedQRImage = generatedQRImage {
                            Image(uiImage: generatedQRImage)
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        }
                        
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
                            print(scannedString ?? "Not scanned")
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
        print("comes into generateQRCode")
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            print("inside 1st if let")
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                print("inside 2nd if let")
                return UIImage(cgImage: cgImage)
            }
        }
        
        print("didn't generateQRCode")
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    CreateViewGroupsPage()
}
