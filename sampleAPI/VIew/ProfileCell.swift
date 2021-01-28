//
//  ProfileCell.swift
//  sampleAPI
//
//  Created by kazuya on 2021/01/29.
//

import SwiftUI

struct ProfileCell: View {
    
    var username: String
    
    var body: some View {
        HStack {
            Image(systemName:"person.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing, 40)
            Text(username)
                .font(.largeTitle)
            Spacer()
        }.frame(width: UIScreen.main.bounds.width - 70,
                height: 50)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.green, lineWidth: 2)
        )
    }
}

struct ProfileCell_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCell(username: "愛知太郎")
    }
}
