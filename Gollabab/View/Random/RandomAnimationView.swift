//
//  RandomAnimationView.swift
//  Gollabab
//
//  Created by Harry on 2022/07/08.
//

import SwiftUI

struct RandomAnimationView: View {
    @ObservedObject var viewModel: MainViewModel
    
    @State var isShowResult: Bool = false
    @State var index: Int = 2
    
    var body: some View {
        ZStack {
            NavigationLink(destination: RandomResultView(viewModel: viewModel), isActive: $isShowResult) {
                EmptyView(title: "")
            }
            
            CustomBackButton(viewModel: viewModel)
                .zIndex(999)
            
            VStack(spacing: 0) {
                Text("여기서 골라밥")
                    .font(.eliceBold(size: 32))
                    .foregroundColor(.primaryBeige)
                    .padding(.bottom, 12)
                
                Text("우주의 기운을 모아서... 멈춰!")
                    .font(.eliceP3())
                    .foregroundColor(.secondaryPink)
                    .padding(.bottom, 48)
                
                LottieAnimationView(filename: CategoryType.allCases.randomElement()?.lottieName() ?? "card_korean")
                    .frame(width: UIScreen.main.bounds.width + 200, height: UIScreen.main.bounds.height / 3)
                    .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(3000)) {
                            isShowResult = true
                        }
                    }
                
                Button {
                    isShowResult = true
                } label: {
                    Text("애니메이션 건너뛰기")
                        .font(.eliceP3())
                        .foregroundColor(.gray500)
                        .underline()
                        .padding(.top, 72)
                }
                
            }
            .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
            .background(Color.text300)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct RandomAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        RandomAnimationView(viewModel: MainViewModel())
    }
}
