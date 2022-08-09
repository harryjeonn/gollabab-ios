//
//  GameView.swift
//  Gollabab
//
//  Created by 전현성 on 2022/07/24.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel: GameViewModel = GameViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("밥값은 누가 낼래?")
                .foregroundColor(.primaryBeige)
                .font(.eliceBold(size: 30))
                .padding(.bottom, 12)
                .padding(.top, 75)
            
            Text("꽝 개수를 골라밥")
                .foregroundColor(.secondaryPink)
                .font(.eliceP3())
            
            Spacer()
            
            HStack(spacing: 63) {
                Button {
                    viewModel.minusBombCount()
                } label: {
                    Text("-")
                        .font(.eliceBold(size: 50))
                        .foregroundColor(.white)
                }

                
                Text("\(viewModel.bombCount)")
                    .font(.eliceBold(size: 50))
                    .foregroundColor(.secondaryRed)
                
                Button {
                    viewModel.plusBombCount()
                } label: {
                    Text("+")
                        .font(.eliceBold(size: 50))
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            Button {
                viewModel.startGame()
                UserDefaultsRepository.shared.plusAdsCount()
            } label: {
                Text("시작!")
                    .font(.eliceP1())
                    .foregroundColor(.white)
                    .frame(minWidth: .zero, maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.secondaryRed)
                    .cornerRadius(100)
                    .padding(EdgeInsets(top: 24, leading: 27, bottom: 0, trailing: 27))
            }
            .padding(.bottom, 93)

            NavigationLink(destination: ChooseCardView(viewModel: viewModel), isActive: $viewModel.isGame) {
                Text("")
            }
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
