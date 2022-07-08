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
            Spacer()
            
            // 카테고리 뷰
            ChooseCategoryView(viewModel: viewModel)
            
            NavigationLink(destination: RandomAnimationView(viewModel: viewModel)) {
                Text("여기서 골라밥!")
                    .font(.eliceP1())
                    .foregroundColor(.white)
                    .frame(minWidth: .zero, maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.secondaryRed)
                    .cornerRadius(100)
                    .padding(EdgeInsets(top: 40, leading: 27, bottom: 27, trailing: 32))
            }
        }
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
        .background(Color.text300)
    }
}

struct RandomView_Previews: PreviewProvider {
    static var previews: some View {
        RandomView()
    }
}
