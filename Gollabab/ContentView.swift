//
//  ContentView.swift
//  Gollabab
//
//  Created by 전현성 on 2022/04/28.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Int = 0
    
    init() {
        UITabBar.appearance().scrollEdgeAppearance = .init()
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                MainView()
                    .tabItem {
                        selection == 0 ? Image("home_fill") : Image("home_outline")
                    }
                    .tag(0)
                
                RandomView()
                    .tabItem {
                        selection == 1 ? Image("shuffle_2_fill") : Image("shuffle_2_outline")
                    }
                    .tag(1)
                
                Text("2")
                    .tabItem {
                        selection == 2 ? Image("smiling_face_fill") : Image("smiling_face_outline")
                    }
                    .tag(2)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
