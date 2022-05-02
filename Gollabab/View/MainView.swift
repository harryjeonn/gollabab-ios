//
//  MainView.swift
//  Gollabab
//
//  Created by Harry on 2022/05/02.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        MainMapView()
            .edgesIgnoringSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
