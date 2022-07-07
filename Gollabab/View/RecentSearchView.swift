//
//  RecentSearchView.swift
//  Gollabab
//
//  Created by Harry on 2022/06/29.
//

import SwiftUI

struct RecentSearchView: View {
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.gray700)
                .frame(height: 1)
                .edgesIgnoringSafeArea(.horizontal)
            
            HStack {
                Spacer().frame(width: 22)
                
                Text("최근 검색어")
                    .foregroundColor(.text200)
                    .font(.eliceP2())
                
                Spacer()
                
                Text("전체삭제")
                    .font(.caption)
                    .foregroundColor(.gray600)
                    .onTapGesture {
                        viewModel.deleteAll()
                    }
                
                Spacer().frame(width: 22)
            }
            .padding(.top, 16)
            
            List {
                ForEach(Array(viewModel.recentKeyword.enumerated()), id: \.0) { idx, keyword in
                    VStack {
                        Text(keyword)
                            .font(.eliceP3())
                            .foregroundColor(.text200)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 15, leading: 22, bottom: 15, trailing: 0))
                        
                        Rectangle()
                            .fill(Color.gray800)
                            .frame(height: 1)
                            .edgesIgnoringSafeArea(.horizontal)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.recentKeywordClicked(keyword)
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteSearchKeyword(indexSet)
                }
            }
            .listStyle(.plain)
            
            Spacer()
        }
        .onAppear {
            viewModel.fetchRecentSearch()
        }
    }
}

struct RecentSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RecentSearchView(viewModel: MainViewModel())
    }
}
