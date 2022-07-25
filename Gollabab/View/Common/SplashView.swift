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
        ZStack {
            VStack {
                Text("골라밥")
            }
            
            if isShow {
                EmptyView(title: "위치 접근 권한이 없으면\n 시작할 수 없다 밥..😥")
            }
        }
        .onAppear {
            viewModel.checkPermisson()
            viewModel.setupLocation()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isShow = true
            }
        }
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
