//
//  ResultCardScrollView.swift
//  Gollabab
//
//  Created by Harry on 2022/07/19.
//

import SwiftUI

struct ResultCardScrollView: View {
    @ObservedObject var viewModel: MainViewModel
    
    @GestureState var offset: CGFloat = 0
    @Binding var currentIndex: Int
    @Binding var isRetry: Bool
    
    let limitCount: CGFloat = 3
    let cardWidth: CGFloat = 351 * 0.7
    let spacing: CGFloat = 20
    
    var body: some View {
        GeometryReader { proxy in
            
            let totalWidth: CGFloat = (cardWidth * limitCount) + (limitCount * spacing)
            let xOffsetToShift = (totalWidth - UIScreen.main.bounds.width) / 2
            
            HStack(spacing: 0) {
                ForEach(Array(viewModel.randomResult.enumerated()), id: \.0) { idx, place in
                    ZStack {
                        Image("card_retry")
                            .resizable()
                            .frame(width: cardWidth)
                            .scaleEffect(idx == currentIndex ? 1.0 : 0.8)
                            .rotation3DEffect(Angle.degrees(isRetry ? 0 : 180), axis: (0,1,0))
                            .zIndex(isRetry ? 1 : 0)
                        
                        ResultCardView(viewModel: viewModel, place: place)
                            .frame(width: cardWidth)
                            .background(Color.white)
                            .cornerRadius(6)
                            .scaleEffect(idx == currentIndex ? 1.0 : 0.8)
                            .rotation3DEffect(Angle.degrees(isRetry ? 180 : 360), axis: (0,1,0))
                            .zIndex(isRetry ? 0 : 1)
                    }
                }
            }
            .padding(.leading, 20)
            .offset(x: (-xOffsetToShift * CGFloat(currentIndex)) + offset + (spacing / 2) + (viewModel.randomResult.count != 3 ? 20 : 0))
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                        
                    })
                    .onEnded({ value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / (proxy.size.width / 2)
                        let roundIndex = progress.rounded()
                        
                        currentIndex = max(min(currentIndex + Int(roundIndex), viewModel.randomResult.count - 1), 0)
                    })
            )
        }
        .animation(.easeInOut, value: offset == 0)
        .frame(height: 351)
        .onAppear {
            currentIndex = viewModel.getMidIndex()
        }
    }
}

//struct ResultCardScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultCardScrollView(viewModel: MainViewModel())
//    }
//}
