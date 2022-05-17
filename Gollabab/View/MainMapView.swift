//
//  MainMapView.swift
//  Gollabab
//
//  Created by Harry on 2022/05/02.
//

import SwiftUI

struct MainMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MTMapView {
        let view = MTMapView()
        
        view.baseMapType = .standard
        
        return view
    }
    
    func updateUIView(_ uiView: MTMapView, context: Context) {
        
    }
}
