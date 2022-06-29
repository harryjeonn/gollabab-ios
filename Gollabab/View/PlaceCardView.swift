//
//  PlaceCardView.swift
//  Gollabab
//
//  Created by Harry on 2022/05/26.
//

import SwiftUI

struct PlaceCardView: View {
    @ObservedObject var viewModel: MainViewModel
    @Binding var index: Int
    
    init(viewModel: MainViewModel, index: Binding<Int>) {
        self.viewModel = viewModel
        self._index = index
    }
    
    @GestureState var offset: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            
            let width = proxy.size.width - (proxy.size.width * 0.28)
            
            HStack(spacing: 10) {
                ForEach(Array(viewModel.places.enumerated()), id: \.0) { idx, place in
                    viewModel.createPlaceCard(place: place, index: idx)
                        .frame(width: UIScreen.main.bounds.width * 0.7, height: 103)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(16)
                        .shadow(color: .cardShadowColor, radius: 3, x: 0, y: 2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.primaryRed, lineWidth: viewModel.isSelectedCard(idx) ? 2 : 0)
                        )
                        .onTapGesture {
                            viewModel.isSelectedCard(idx) ? viewModel.showSafari.toggle() : withAnimation { viewModel.slideCard(idx) }
                        }
                        .fullScreenCover(isPresented: $viewModel.showSafari, content: {
                            SafariView(url: viewModel.getURL())
                                .edgesIgnoringSafeArea(.all)
                        })
                }
            }
            .padding(.leading, 22)
            .padding(.bottom, 24)
            .offset(x: (CGFloat(viewModel.cardCurrentIndex) * -width) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        viewModel.cardCurrentIndex = max(min(viewModel.cardCurrentIndex + Int(roundIndex), viewModel.places.count - 1), 0)
                        
                        viewModel.cardCurrentIndex = index
                    })
                    .onChanged({ value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        index = max(min(viewModel.cardCurrentIndex + Int(roundIndex), viewModel.places.count - 1), 0)
                    })
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }
}

//struct PlaceCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceCardView()
//    }
//}
