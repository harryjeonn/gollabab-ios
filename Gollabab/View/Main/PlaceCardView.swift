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
            EmptyView(title: "주변엔 없다밥..😢")
        } else {
            GeometryReader { proxy in
                
                let xOffsetToShift = UIScreen.main.bounds.width * 0.75 + 10
                
                HStack(spacing: 10) {
                    ForEach(Array(viewModel.places.enumerated()), id: \.0) { idx, place in
                        viewModel.createPlaceCard(place: place, index: idx)
                    }
                }
                .padding(.leading, 22)
                .offset(x: offset - (CGFloat(viewModel.cardCurrentIndex) * xOffsetToShift))
                .gesture(
                    DragGesture()
                        .updating($offset, body: { value, out, _ in
                            out = value.translation.width
                        })
                        .onEnded({ value in
                            let offsetX = value.translation.width
                            let progress = -offsetX / (proxy.size.width / 2)
                            let roundIndex = progress.rounded()
                            
                            index = max(min(viewModel.cardCurrentIndex + Int(roundIndex), viewModel.places.count - 1), 0)
                            
                            viewModel.slideCard(index)
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
