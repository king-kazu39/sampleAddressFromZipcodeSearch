//
//  SearchButton.swift
//  sampleAPI
//
//  Created by kazuya on 2021/02/05.
//

import SwiftUI

struct ButtonAction: View {
    
    var buttonTitle: String
    var width: CGFloat
    var action: ()->Void
    
    var body: some View {
        Button(action: {
            // api request
            action()
        }){
            Text(buttonTitle)
                .frame(width: width,
                       height: 40)
                .foregroundColor(Color.white)
        }.background(Color.blue)
        .cornerRadius(10)
        .padding(.horizontal, 10)
    }
}


struct ButtonAction_Previews: PreviewProvider {
    static var previews: some View {
        ButtonAction(buttonTitle: "Search", width: 60, action: {})
    }
}
