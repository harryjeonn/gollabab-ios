//
//  CategoryView.swift
//  Gollabab
//
//  Created by Harry on 2022/06/28.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var caterory = CategoryType.allCases
    
    var body: some View {
        ForEach(Array(caterory.enumerated()), id: \.0) { index, type in
            Text("\(type.title())")
                .font(.eliceP4())
                .foregroundColor(viewModel.isSelectedCategory(index) ? .primaryBeige : .text300)
                .padding(getSelectedPadding(index))
                .background(viewModel.isSelectedCategory(index) ? Color.gray100 : Color.white)
                .cornerRadius(100)
                .onTapGesture {
                    viewModel.categoryCurrenIndex = index
                    viewModel.fetchPlace(type)
                }
        }
    }
    
    func getSelectedPadding(_ index: Int) -> EdgeInsets {
        if viewModel.isSelectedCategory(index) {
            return EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10)
        } else {
            return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(viewModel: MainViewModel())
    }
}
