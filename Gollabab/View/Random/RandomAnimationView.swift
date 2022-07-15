//
//  RandomAnimationView.swift
//  Gollabab
//
//  Created by Harry on 2022/07/08.
//

import SwiftUI

struct RandomAnimationView: View {
    @ObservedObject var viewModel: RandomViewModel
    
    @State var isShowResult: Bool = false
    @State var index: CGFloat = 2
    
    var body: some View {
        ZStack {
            NavigationLink(destination: RandomResultView(viewModel: viewModel), isActive: $isShowResult) {
                EmptyView()
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
                
                GeometryReader { proxy in
                    let width = proxy.size.width - (proxy.size.width / 2)
                    
                    HStack(spacing: -40) {
                        ForEach(0..<50, id: \.self) { _ in
                            Image("card_shuffle")
                                .resizable()
                                .frame(width: 178, height: 267)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 21, bottom: 0, trailing: 21))
                    .offset(x: index * -width)
                    .onReceive(viewModel.places.publisher) { _ in
                        withAnimation(.easeInOut(duration: 2)) {
                            index = 30
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(2500)) {
                            isShowResult = true
                        }
                    }
                }
                .frame(height: 267)
                
                Button {
                    // 투표결과 보여주기
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
            .onAppear {
                viewModel.fetchPlace()
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct RandomAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        RandomAnimationView(viewModel: RandomViewModel())
    }
}
