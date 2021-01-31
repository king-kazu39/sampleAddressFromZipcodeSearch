//
//  AddressListView.swift
//  sampleAPI
//
//  Created by kazuya on 2021/01/29.
//

import SwiftUI

struct AddressListView: View {
    @Binding var addressStrings: [String]
    @ObservedObject var profileEditVM: ProfileEditViewModel
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
                    self.profileEditVM.addressString = address
                }) {
                    Text("\(address)")
                }
            }
        }
    }
}

struct AddressListView_Previews: PreviewProvider {
    static var previews: some View {
        AddressListView(addressStrings: .constant(["南風原町","西原町"]), profileEditVM: ProfileEditViewModel())
    }
}
