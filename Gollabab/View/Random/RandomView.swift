//
//  RandomView.swift
//  Gollabab
//
//  Created by Harry on 2022/07/07.
//

import SwiftUI

struct RandomView: View {
    @StateObject private var viewModel = RandomViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("카테고리 선택해밥")
                .font(.eliceBold(size: 22))
                .foregroundColor(.white)
                .padding(.top, 54)
                .padding(.bottom, 38)
            
            // 카테고리 뷰
            ChooseCategoryView(viewModel: viewModel)
            
            NavigationLink(destination: RandomAnimationView(viewModel: viewModel), isActive: $viewModel.isNavigationActive) {
                Text("")
            }
            
            Text("여기서 골라밥!")
                .font(.eliceP1())
                .foregroundColor(.white)
                .frame(minWidth: .zero, maxWidth: .infinity)
                .frame(height: 48)
                .background(Color.secondaryRed)
                .cornerRadius(100)
                .padding(EdgeInsets(top: 40, leading: 27, bottom: 40, trailing: 27))
                .onTapGesture {
                    // TODO: - 검색결과 비어있는지 확인
                    viewModel.fetchPlace()
                    viewModel.isNavigationActive = true
                }
        }
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
        .background(Color.text300)
        .onAppear {
            viewModel.isNavigationActive = false
        }
    }
}

struct RandomView_Previews: PreviewProvider {
    static var previews: some View {
        RandomView()
    }
}
