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
            Text("プロフィール一覧")
                .navigationBarTitle("プロフィール一覧", displayMode: .inline)
        }
    }
}

struct ProfileListView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileListView()
    }
}
