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
        setupMapView(view)
        moveMapMyLocation(view)
        
        return view
    }
    
    func updateUIView(_ uiView: MTMapView, context: Context) {
        if uiView.poiItems.isEmpty {
            uiView.addPOIItems(viewModel.createPoiItems())
        }
        
        moveMapPlace(uiView)
    }
    
    func setupMapView(_ view: MTMapView) {
        view.baseMapType = .standard
        view.showCurrentLocationMarker = true
        view.currentLocationTrackingMode = .onWithoutHeadingWithoutMapMoving
    }
    
    func moveMapPlace(_ view: MTMapView) {
        if view.poiItems.isEmpty == false {
            guard let poiItem = view.poiItems[viewModel.currentIndex] as? MTMapPOIItem else { return }
            view.select(poiItem, animated: true)
            view.setMapCenter(poiItem.mapPoint, animated: true)
        }
    }
    
    func moveMapMyLocation(_ view: MTMapView) {
        viewModel.mtMapPoint
            .subscribe(onNext: { view.setMapCenter($0, zoomLevel: .zero, animated: true) })
            .disposed(by: disposeBag)
    }
}
