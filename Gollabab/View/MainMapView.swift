//
//  MainMapView.swift
//  Gollabab
//
//  Created by Harry on 2022/05/02.
//

import SwiftUI
import RxSwift

struct MainMapView: UIViewRepresentable {
    @ObservedObject var viewModel: MainViewModel
    
    var disposeBag = DisposeBag()
    
    func makeUIView(context: Context) -> MTMapView {
        viewModel.setupLocation()
        let view = MTMapView()
        
        view.baseMapType = .standard
        view.showCurrentLocationMarker = true
        view.currentLocationTrackingMode = .onWithoutHeading
        
        viewModel.mtMapPoint
            .subscribe(onNext: { view.setMapCenter($0, animated: true)})
            .disposed(by: disposeBag)
        
        return view
    }
    
    func updateUIView(_ uiView: MTMapView, context: Context) {
        
    }
}
