//
//  ContentView.swift
//  sampleAPI
//
//  Created by kazuya on 2020/11/01.
//

import SwiftUI

struct ContentView: View {
    
    @State var zipcode = ""
    @State var address01 = ""
    @State var address02 = ""
    
    @ObservedObject var contentVM = ContentViewModel()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    TextField("Please input zipcode", text: $zipcode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 15)
                    Button(action: {
                        // api request
                        self.contentVM.getAddress(self.zipcode) {
                            if !self.contentVM.isPresented {
                                self.address01 = self.contentVM.addressString
                            }
                        }
                    }){
                        Text("Search")
                            .frame(width: 60, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.white)
                    }.background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                    .sheet(isPresented: self.$contentVM.isPresented,
                           onDismiss: {
                            self.address01 = self.contentVM.addressString
                           }) {
                        AddressListView(addressStrings: self.$contentVM.addressArrayStrings,
                                        contentVM: self.contentVM)
                    }
                    .alert(isPresented: self.$contentVM.alertStruct.showAlert) {
                        Alert(title: Text("\(self.contentVM.alertStruct.alertTitle)"),
                              message: Text("\(self.contentVM.alertStruct.alertMsg)"))
                    }
                }
                TextField("Please input your address01", text: $address01)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 15)
                TextField("Please input your address02", text: $address02)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 15)
                Button(action: {
                    // save action
                }){
                    Text("save")
                        .frame(width: 60, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                }.background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal, 10)
            }
        }
    }
}

struct AddressListView: View {
    @Binding var addressStrings: [String]
    @ObservedObject var contentVM: ContentViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            List(addressStrings, id: \.self) { address in
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    self.contentVM.addressString = address
                }) {
                    Text("\(address)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
