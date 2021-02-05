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
    
    @State var showingActionSheet = false
    @State var isShowCamera = false
    @State var isShowPhotoLibrary = false
    @State var inputImage: UIImage? = UIImage()
    @State var image:Image = Image(systemName: "person.circle")
    
    @ObservedObject var profileEditVM = ProfileEditViewModel()
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    
                    Button(action: {
                        self.showingActionSheet = true
                    }) {
                        image
                            .resizable()
                            .frame(width: 150, height: 150)
                            .padding()
                    }
                    ZStack {
                        Text("")
                            .actionSheet(isPresented: self.$showingActionSheet) {
                                ActionSheet(title: Text("画像選択"),
                                            message: Text("画像を選択します"),
                                            buttons: [
                                                .default(Text("写真から選択")) {
                                                    self.isShowPhotoLibrary.toggle()
                                                },
                                                .default(Text("写真を撮る")) {
                                                    self.isShowCamera.toggle()
                                                },
                                                .cancel()
                                            ])
                            }
                            .sheet(isPresented: self.$isShowPhotoLibrary,
                                   onDismiss: loadImage) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$inputImage)
                            }
                        Text("")
                            .sheet(isPresented: self.$isShowCamera,
                                   onDismiss: loadImage) {
                                ImagePicker(sourceType: .camera, selectedImage: self.$inputImage)
                            }
                    }
                    
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
                        Button(action: {
                            // api request
                            self.profileEditVM.getAddress(self.zipcode) {
                                if !self.profileEditVM.isPresented {
                                    self.address01 = self.profileEditVM.addressString
                                }
                            }
                        }){
                            Text("Search")
                                .frame(width: 60, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color.white)
                        }.background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
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
                    Button(action: {
                        // save action
                    }){
                        Text("save")
                            .frame(width: UIScreen.main.bounds.width - 30,
                                   height: 40)
                            .foregroundColor(Color.white)
                    }.background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
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
