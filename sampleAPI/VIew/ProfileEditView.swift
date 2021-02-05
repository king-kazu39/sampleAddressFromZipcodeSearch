//
//  ContentView.swift
//  sampleAPI
//
//  Created by kazuya on 2020/11/01.
//

import SwiftUI

struct ProfileEditView: View {
    
    var viewTitle: String
    @State var name = ""
    @State var phoneNumber = ""
    @State var zipcode = ""
    @State var address01 = ""
    @State var address02 = ""
    
    @State var showActionSheet = false
    @State var showCamera = false
    @State var showPhotoLibrary = false
    
    @ObservedObject var profileEditVM = ProfileEditViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    
                    ActionSheetButton(showingActionSheet: self.$showActionSheet,
                                      isShowCamera: self.$showCamera,
                                      isShowPhotoLibrary: self.$showPhotoLibrary)
                    
                    TextField("Please input your name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 15)
                    TextField("Please input your phone number", text: $phoneNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 15)
                    HStack {
                        TextField("Please input zipcode", text: $zipcode)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 15)
                        
                        ButtonAction(buttonTitle: "Search",
                                     width: 60) {
                            self.profileEditVM.getAddress(self.zipcode) {
                                if !self.profileEditVM.isPresented {
                                    self.address01 = self.profileEditVM.addressString
                                }
                            }
                        }
                        .sheet(isPresented: self.$profileEditVM.isPresented,
                               onDismiss: {
                                self.address01 = self.profileEditVM.addressString
                               }) {
                            AddressListView(addressStrings: self.$profileEditVM.addressArrayStrings,
                                            profileEditVM: self.profileEditVM)
                        }
                        .alert(isPresented: self.$profileEditVM.alertStruct.showAlert) {
                            Alert(title: Text("\(self.profileEditVM.alertStruct.alertTitle)"),
                                  message: Text("\(self.profileEditVM.alertStruct.alertMsg)"))
                        }
                    }
                    TextField("Please input your address01", text: $address01)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 15)
                    
                    ButtonAction(buttonTitle: "Save",
                                 width: UIScreen.main.bounds.width - 30,
                                 action: {})
                }
                .navigationBarTitle(viewTitle, displayMode: .inline)
            }
        }
    }
}




struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(viewTitle: "プロフィール登録")
    }
}
