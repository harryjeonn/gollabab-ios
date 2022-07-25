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
                    .font(.aggroBold(63))
                    .foregroundColor(.selectedRed)
                    .padding(.bottom, 20)
                
                Image("splash")
                    .resizable()
                    .frame(width: 350, height: 350)
            }
            
            if isShow {
                VStack(spacing: 0) {
                    Text("위치 접근 권한 허용")
                        .foregroundColor(.text300)
                        .font(.eliceP1())
                        .padding(.top, 24)
                    
                    Text("근처 식당을 찾으려면\n접근 권한이 필요하다밥 ☺️")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.text200)
                        .font(.eliceP3())
                        .padding(.top, 20)
                    
                    Button {
                        openSettings()
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            Text("설정하러가기")
                                .font(.eliceBold(size: 16))
                                .foregroundColor(.primaryBeige)
                            
                            Image("chevron_right_outline_beige")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.primaryBeige)
                        }
                        .frame(minWidth: .zero, maxWidth: .infinity)
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
                        .background(Color.secondaryRed)
                        .padding(.top, 20)
                    }
                }
                .frame(minWidth: .zero, maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(16)
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                .shadow(color: .cardShadowColor, radius: 3, x: 0, y: 2)
                .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
                .background(Color.black.opacity(0.6))
            }
        }
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
        .background(Color.primaryBeige)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                viewModel.checkPermisson()
                viewModel.setupLocation()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                isShow = !viewModel.isPermission
            }
        }
    }
    
    private func openSettings(){
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
