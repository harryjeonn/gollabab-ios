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
    
    @GestureState var offset: CGFloat = 0
    
    var body: some View {
        if viewModel.places.isEmpty {
            EmptyView()
                .shadow(color: .cardShadowColor, radius: 3, x: 0, y: 2)
        } else {
            GeometryReader { proxy in
                
                let width = proxy.size.width - (proxy.size.width * 0.28)
                
                HStack(spacing: 10) {
                    ForEach(Array(viewModel.places.enumerated()), id: \.0) { idx, place in
                        viewModel.createPlaceCard(place: place, index: idx)
                    }
                }
                .padding(.leading, 22)
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
                            
                            viewModel.slideCard(index)
                        })
                        .onChanged({ value in
                            let offsetX = value.translation.width
                            let progress = -offsetX / width
                            let roundIndex = progress.rounded()
                            
                            index = max(min(viewModel.cardCurrentIndex + Int(roundIndex), viewModel.places.count - 1), 0)
                        })
                )
            }
            .frame(height: UIScreen.main.bounds.height * 0.13)
            .animation(.easeInOut, value: offset == 0)
        }
    }
}

//struct PlaceCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceCardView()
//    }
//}
