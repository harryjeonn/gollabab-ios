//
//  SearchView.swift
//  Gollabab
//
//  Created by Harry on 2022/06/29.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        HStack(spacing: 8) {
            Image(viewModel.isEditing ? "arrow_ios_back" : "search_outline")
                .onTapGesture {
                    viewModel.keyword = ""
                    viewModel.dismissRecentSearchView()
                }
            
            TextField("오늘은 어떤밥?", text: $viewModel.keyword, onEditingChanged: { viewModel.isEditing = $0 }, onCommit: {
                if viewModel.keyword != "" {
                    viewModel.searchPlace()
                }
            })
            .font(.eliceP3())
            
            Spacer()
            
            if viewModel.keyword != "" {
                Image("close_circle")
                    .padding(.trailing, 16)
                    .onTapGesture {
                        viewModel.keyword = ""
                    }
            }
        }
        .padding(.leading, 12)
        .frame(height: 40)
        .background(Color.gray800)
        .cornerRadius(12)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: MainViewModel())
    }
}
