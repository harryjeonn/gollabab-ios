//
//  GameView.swift
//  Gollabab
//
//  Created by 전현성 on 2022/07/24.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("🕹열심히 개발중🕹")
                .font(.eliceBold(size: 32))
                .foregroundColor(.white)
                .padding(.bottom, 11)
            
            Text("재밌는 게임으로 돌아온다밥")
                .font(.eliceP3())
                .foregroundColor(.secondaryPink)
        }
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
        .background(Color.text300)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
