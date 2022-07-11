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
                    .font(.eliceBold(size: 30))
                    .foregroundColor(.primaryBeige)
                    .padding(.bottom, 12)
                
                Text("우주의 기운을 모아서... 멈춰!")
                    .font(.eliceP3())
                    .foregroundColor(.secondaryPink)
                    .padding(.bottom, 65)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        Image("card_clover")
                            .resizable()
                            .frame(width: 120, height: 180)
                        
                        Image("card_diamond")
                            .resizable()
                            .frame(width: 120, height: 180)
                        
                        Image("card_heart")
                            .resizable()
                            .frame(width: 120, height: 180)
                    }
                    .padding(EdgeInsets(top: 0, leading: 21, bottom: 0, trailing: 21))
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 110, trailing: 0))
                
                Button {
                    // 투표결과 보여주기
                } label: {
                    Text("멈춰!")
                        .font(.eliceP1())
                        .foregroundColor(.white)
                        .frame(minWidth: .zero, maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.secondaryRed)
                        .cornerRadius(100)
                }
                .padding(EdgeInsets(top: 40, leading: 27, bottom: 27, trailing: 32))
                
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
