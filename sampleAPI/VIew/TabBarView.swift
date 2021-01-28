//
//  TabBarView.swift
//  sampleAPI
//
//  Created by kazuya on 2021/01/28.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ProfileListView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("プロフィール一覧")
                }
            CreateView()
                .tabItem{
                    Image(systemName: "person.crop.circle.badge.plus")
                    Text("プロフィール登録")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
