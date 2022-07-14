//
//  RandomAnimationView.swift
//  Gollabab
//
//  Created by Harry on 2022/07/08.
//

import SwiftUI

struct RandomAnimationView: View {
    @ObservedObject var viewModel: RandomViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var index: CGFloat = 2
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("arrow_ios_back_outline")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.top, 16)
                            .padding(.leading, 22)
                    }
                    
                    Spacer()
                }
                Spacer()
            }
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
                    
                    HStack(spacing: 20) {
                        ForEach(0..<50, id: \.self) { _ in
                            Image("card_clover")
                                .resizable()
                                .frame(width: 178, height: 267)
                            
                            Image("card_diamond")
                                .resizable()
                                .frame(width: 178, height: 267)
                            
                            Image("card_heart")
                                .resizable()
                                .frame(width: 178, height: 267)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 21, bottom: 0, trailing: 21))
                    .offset(x: index * -width)
                    .onReceive(viewModel.places.publisher) { _ in
                        withAnimation(.easeInOut(duration: 3)) {
                            index = 48
                        }
                    }
                }
                .frame(height: 267)
                
                Button {
                    // 투표결과 보여주기
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
