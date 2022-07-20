//
//  RandomResultView.swift
//  Gollabab
//
//  Created by Harry on 2022/07/15.
//

import SwiftUI

struct RandomResultView: View {
    @ObservedObject var viewModel: MainViewModel
    @State var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            CustomBackButton(viewModel: viewModel)
                .zIndex(999)
            VStack(spacing: 0) {
                ResultCardScrollView(viewModel: viewModel, currentIndex: $currentIndex)
                    .padding(.top, 70)
                    .padding(.bottom, 95)
                
                HStack(spacing: 24) {
                    Button {
                        viewModel.previousIsRandom = true
                        viewModel.showMapButtonClicked(currentIndex)
                    } label: {
                        Text("지도 보여줘")
                            .font(.eliceP1())
                            .foregroundColor(.white)
                            .frame(minWidth: .zero, maxWidth: .infinity)
                            .frame(height: 48)
                            .overlay(RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.gray500, lineWidth: 2))
                    }
                    .padding(.leading, 27)
                    
                    Button {
                        viewModel.retryGetRandomPlaces()
                    } label: {
                        Text("다시 골라밥")
                            .font(.eliceP1())
                            .foregroundColor(.white)
                            .frame(minWidth: .zero, maxWidth: .infinity)
                            .frame(height: 48)
                            .background(Color.secondaryRed)
                            .cornerRadius(100)
                    }
                    .padding(.trailing, 27)
                }
                .padding(.bottom, 32)
            }
        }
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
        .background(Color.text300)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct RandomResultView_Previews: PreviewProvider {
    static var previews: some View {
        RandomResultView(viewModel: MainViewModel())
    }
}
