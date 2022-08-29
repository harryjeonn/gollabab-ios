//
//  ChooseCardView.swift
//  Gollabab
//
//  Created by Harry on 2022/08/04.
//

import SwiftUI

struct ChooseCardView: View {
    @ObservedObject var viewModel: GameViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Image("arrow_ios_back_outline")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        viewModel.stopGame()
                    }
                
                Spacer()
            }
            .padding(EdgeInsets(top: 16, leading: 22, bottom: 16, trailing: 0))
            
            Text("한 장씩 선택해밥!")
                .font(.eliceBold(size: 22))
                .foregroundColor(.primaryBeige)
                .padding(.bottom, 28)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.gameItem, id: \.self) { card in
                    CardBackView(viewModel: viewModel, card: card)
                }
            }
            .padding(.leading, 21)
            .padding(.trailing, 21)
            
            Spacer()
            
            Button {
                viewModel.stopGame()
            } label: {
                Text("확인")
                    .font(.eliceP1())
                    .foregroundColor(viewModel.isAllSelectedBomb() ? .white : .primaryBeige)
                    .frame(minWidth: .zero, maxWidth: .infinity)
                    .frame(height: 48)
                    .background(viewModel.isAllSelectedBomb() ? Color.secondaryRed : Color.gray700)
                    .cornerRadius(100)
                    .padding(EdgeInsets(top: 24, leading: 27, bottom: 0, trailing: 27))
            }
            .padding(.bottom, 32)
            .disabled(!viewModel.isAllSelectedBomb())
        }
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
        .background(Color.backgroundBlackColor)
        .navigationBarHidden(true)
        .navigationTitle("")
    }
}

struct ChooseCardView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseCardView(viewModel: GameViewModel())
    }
}
