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
                        ProfileCell(username: "愛知太郎")
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 30)
            }.frame(width: UIScreen.main.bounds.width - 30,
                    height: .infinity)
            .navigationBarTitle("プロフィール一覧", displayMode: .inline)
        }
    }
}

struct ProfileListView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileListView()
    }
}
