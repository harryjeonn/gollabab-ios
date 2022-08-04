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
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "EliceDigitalBaeumOTF", size: 11)!], for: .normal)
    }
    
    var body: some View {
        switch viewModel.isPermission {
        case .allow, .notAllow:
            ZStack {
                NavigationView {
                    TabView(selection: $viewModel.selectionTab) {
                        MainView(viewModel: viewModel)
                            .tabItem {
                                viewModel.selectionTab == 0 ? Image("tab_map_active") : Image("tab_map")
                                Text("지도")
                            }
                            .tag(0)
                            .navigationTitle("")
                            .navigationBarHidden(true)
                        
                        RandomView(viewModel: viewModel)
                            .tabItem {
                                viewModel.selectionTab == 1 ? Image("tab_random_active") : Image("tab_random")
                                Text("랜덤")
                            }
                            .tag(1)
                            .navigationTitle("")
                            .navigationBarHidden(true)
                        
                        GameView()
                            .tabItem {
                                viewModel.selectionTab == 2 ? Image("tab_game_active") : Image("tab_game")
                                Text("게임")
                            }
                            .tag(2)
                            .navigationTitle("")
                            .navigationBarHidden(true)
                    }
                    .accentColor(.primaryRed)
                    .onAppear {
                        viewModel.checkAdsCount()
                    }
                }
                
                if viewModel.isPermission == .notAllow {
                    PermissionView()
                }
                
            }
        case .unknown:
            SplashView(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
