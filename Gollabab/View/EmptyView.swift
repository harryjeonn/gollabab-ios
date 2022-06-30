//
//  EmptyView.swift
//  Gollabab
//
//  Created by Harry on 2022/06/30.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        Text("주변엔 없다밥..😢")
            .foregroundColor(.text200)
            .font(.eliceP2Regular())
            .frame(width: UIScreen.main.bounds.width * 0.7, height: 103)
            .background(Color.white)
            .cornerRadius(16)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
