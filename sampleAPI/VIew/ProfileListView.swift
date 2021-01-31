//
//  ProfileListView.swift
//  sampleAPI
//
//  Created by kazuya on 2021/01/28.
//

import SwiftUI

struct ProfileListView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(0..<10) {_ in
                    LazyVStack {
                        NavigationLink(destination: ProfileEditView(viewTitle: "プロフィール編集")) {
                            ProfileCell(username: "愛知太郎")
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 30)
            }
            .frame(minWidth: 0,
                   maxWidth: UIScreen.main.bounds.width - 30,
                   minHeight: 0,
                   maxHeight: .infinity)
            .navigationBarTitle("プロフィール一覧", displayMode: .inline)
        }
    }
}

struct ProfileListView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileListView()
    }
}
