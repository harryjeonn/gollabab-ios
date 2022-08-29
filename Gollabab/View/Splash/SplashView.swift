//
//  SplashView.swift
//  Gollabab
//
//  Created by Harry on 2022/07/25.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var isShow: Bool = false
    
    var body: some View {
        VStack {
            LottieAnimationView(filename: "splash")
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                .padding(.bottom, UIScreen.main.bounds.height * 0.25)
        }
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
        .background(Color.backgroundBlackColor)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) {
                viewModel.checkPermisson()
                viewModel.setupLocation()
            }
        }
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
