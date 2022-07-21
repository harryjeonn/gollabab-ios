//
//  EmptyView.swift
//  Gollabab
//
//  Created by Harry on 2022/06/30.
//

import SwiftUI

struct EmptyView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(.text200)
            .font(.eliceP2Regular())
            .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.13)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .cardShadowColor, radius: 3, x: 0, y: 2)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(title: "주변엔 없다밥..😢")
    }
}
