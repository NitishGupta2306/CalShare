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
    @State private var generateQR = false
    @State private var scanQR = false
    let testString = "testString00123"
    let testScannedString = "testString00123"
    
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
                        
                        
                        Button(action: {
                            print("Generate QR")
                            self.generateQR.toggle()
                            
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
                        
                        if generateQR {
                            Image(uiImage: generateQRCode(from: "\(testString)"))
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
                        
                        Spacer()
                    }
                }
            //}
                .navigationDestination(isPresented: $addCal) {
                    CreateCalendarPage()
                        .navigationBarBackButtonHidden()
                }
                .navigationDestination(isPresented: $addFriend) {
                    addFriendsPage()
                        .navigationBarBackButtonHidden()
                }
                .sheet(isPresented: $scanQR) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "\(testScannedString)", completion: handleScan)
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
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        scanQR = true
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "")
            guard details.count == 1 else {return}
            
            let string = details[0]
            print(string)
        case .failure(let error):
            print("scan failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CreateViewGroupsPage()
}
