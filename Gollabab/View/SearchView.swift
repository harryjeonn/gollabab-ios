//
//  SearchView.swift
//  Gollabab
//
//  Created by Harry on 2022/06/29.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var keyword: String = ""
    
    var body: some View {
        HStack(spacing: 8) {
            Image(isEmptyKeyword() ? "search_outline" : "arrow_ios_back")
                .onTapGesture {
                    keyword = ""
                }
            
            TextField("오늘은 어떤밥?", text: $keyword, onCommit: {
                if isEmptyKeyword() == false {
                    viewModel.searchPlace(keyword)
                }
            })
            .font(.eliceP3())
        }
        .padding(.leading, 12)
        .frame(height: 40)
        .background(Color.gray800)
        .cornerRadius(12)
    }
    
    func isEmptyKeyword() -> Bool {
        return keyword == "" ? true : false
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: MainViewModel())
    }
}
