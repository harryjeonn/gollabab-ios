//
//  ChooseCategoryView.swift
//  Gollabab
//
//  Created by Harry on 2022/07/07.
//

import SwiftUI

struct ChooseCategoryView: View {
    @ObservedObject var viewModel: MainViewModel
    
    let category: [CategoryType] = [.korean, .chinese, .casual, .western, .japanese, .fastfood, .asian, .chicken, .cafe, .snack, .all]
    let columns = [GridItem(.adaptive(minimum: (UIScreen.main.bounds.width - 42 - 20) / 3))]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(category, id: \.self) { item in
                VStack(spacing: 0) {
                    Image(item.image())
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(EdgeInsets(top: 8, leading: 22, bottom: 0, trailing: 22))
                    
                    Text(item.rawValue)
                        .font(.eliceP3())
                        .foregroundColor(.text300)
                        .padding(.bottom, 22)
                }
                .background(Color.primaryBeige)
                .overlay(content: {
                    if viewModel.isDisable(item) {
                        Rectangle()
                            .fill(.black.opacity(0.35))
                    }
                })
                .cornerRadius(12)
                .onTapGesture {
                    viewModel.selectItem(item)
                }
            }
        }
        .padding(.leading, 22)
        .padding(.trailing, 22)
    }
}

struct ChooseCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseCategoryView(viewModel: MainViewModel())
    }
}
