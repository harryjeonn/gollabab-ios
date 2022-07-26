//
//  ContentView.swift
//  Gollabab
//
//  Created by 전현성 on 2022/04/28.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: MainViewModel = MainViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        if viewModel.isPermission {
            NavigationView {
                TabView(selection: $viewModel.selectionTab) {
                    MainView(viewModel: viewModel)
                        .tabItem {
                            viewModel.selectionTab == 0 ? Image("home_fill") : Image("home_outline")
                        }
                        .tag(0)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                    
                    RandomView(viewModel: viewModel)
                        .tabItem {
                            viewModel.selectionTab == 1 ? Image("shuffle_2_fill") : Image("shuffle_2_outline")
                        }
                        .tag(1)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                    
                    GameView()
                        .tabItem {
                            viewModel.selectionTab == 2 ? Image("smiling_face_fill") : Image("smiling_face_outline")
                        }
                        .tag(2)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                }
                .onAppear {
                    viewModel.checkAdsCount()
                }
            }
        } else {
            SplashView(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
