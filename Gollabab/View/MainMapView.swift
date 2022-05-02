//
//  MainMapView.swift
//  Gollabab
//
//  Created by Harry on 2022/05/02.
//

import SwiftUI
import NMapsMap

struct MainMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 17
        
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        
    }
}
