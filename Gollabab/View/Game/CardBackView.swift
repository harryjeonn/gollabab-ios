//
//  BackCardView.swift
//  Gollabab
//
//  Created by Harry on 2022/08/05.
//

import SwiftUI
import AudioToolbox

struct CardBackView: View {
    @ObservedObject var viewModel: GameViewModel
    
    let card: String
    
    @State var isFliped: Bool = false
    
    let cardWidth = (UIScreen.main.bounds.width - 42 - 40) / 3
    
    var body: some View {
        ZStack {
            Image("game_card_back")
                .resizable()
                .frame(width: cardWidth, height: cardWidth * 1.5)
                .rotation3DEffect(Angle.degrees(isFliped ? 180 : 360), axis: (0,1,0))
                .zIndex(isFliped ? 0 : 1)
            
            CardFrontView(card: card)
                .frame(width: cardWidth, height: cardWidth * 1.5)
                .rotation3DEffect(Angle.degrees(isFliped ? 0 : 180), axis: (0,1,0))
                .zIndex(isFliped ? 1 : 0)
        }
        .onTapGesture {
            withAnimation {
                isFliped = true
            }
            
            if card.contains("꽝") && viewModel.selectedBombCount < viewModel.bombCount {
                viewModel.selectedBombCount += 1
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {   }
            }
        }
            
    }
}

struct BackCardView_Previews: PreviewProvider {
    static var previews: some View {
        CardBackView(viewModel: GameViewModel(), card: "")
    }
}
