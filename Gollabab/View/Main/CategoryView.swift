//
//  CategoryView.swift
//  Gollabab
//
//  Created by Harry on 2022/06/28.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var caterory = CategoryType.allCases.filter { $0 != .other }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(spacing: 6) {
                ForEach(Array(caterory.enumerated()), id: \.0) { index, type in
                    Text("\(type.rawValue)")
                        .font(.eliceP4())
                        .foregroundColor(viewModel.isSelectedCategory(index) ? .primaryBeige : .text300)
                        .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                        .background(viewModel.isSelectedCategory(index) ? Color.gray100 : Color.white)
                        .cornerRadius(100)
                        .onTapGesture {
                            viewModel.categoryCurrentIndex = index
                            viewModel.fetchPlace(type)
                        }
                }
            }
            .padding(EdgeInsets(top: 8, leading: 22, bottom: 8, trailing: 22))
        })
        
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
