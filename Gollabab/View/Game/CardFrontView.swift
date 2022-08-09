//
//  CardFrontView.swift
//  Gollabab
//
//  Created by Harry on 2022/08/05.
//

import SwiftUI

struct CardFrontView: View {
    let card: String
    
    var body: some View {
        if card.contains("꽝") {
            Image("game_card_front")
                .resizable()
        } else {
            Image("game_card_pass")
                .resizable()
        }
    }
}

struct CardFrontView_Previews: PreviewProvider {
    static var previews: some View {
        CardFrontView(card: "Test Card")
    }
}
