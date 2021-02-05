//
//  ActionSheetButton.swift
//  sampleAPI
//
//  Created by kazuya on 2021/02/05.
//

import SwiftUI

struct ActionSheetButton: View {
    
    @Binding var showingActionSheet: Bool
    @Binding var isShowCamera: Bool
    @Binding var isShowPhotoLibrary: Bool
    @State var inputImage: UIImage? = UIImage(named: "person.circle")
    @State var image:Image = Image(systemName: "person.circle")
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    var body: some View {
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
    }
}

struct ActionSheetButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetButton(showingActionSheet: .constant(false),
                          isShowCamera: .constant(false),
                          isShowPhotoLibrary: .constant(false))
    }
}
