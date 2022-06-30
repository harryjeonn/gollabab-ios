//
//  MainMapView.swift
//  Gollabab
//
//  Created by Harry on 2022/05/02.
//

import SwiftUI
import Combine

struct MainMapView: UIViewRepresentable {
    @ObservedObject var viewModel: MainViewModel
    
    func makeUIView(context: Context) -> MTMapView {
        viewModel.setupLocation()
        let view = MTMapView()
        setupPoiItems(view)
        setupMapView(view)
        moveMapMyLocation(view)
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: MTMapView, context: Context) {
    }
    
    func setupPoiItems(_ view: MTMapView) {
        viewModel.poiItems
            .sink { items in
                view.removeAllPOIItems()
                view.addPOIItems(items)
                self.moveMapPlace(view)
            }.store(in: &viewModel.cancelBag)
    }
    
    func setupMapView(_ view: MTMapView) {
        view.baseMapType = .standard
        view.showCurrentLocationMarker = true
        view.currentLocationTrackingMode = .onWithoutHeadingWithoutMapMoving
    }
    
    func moveMapPlace(_ view: MTMapView) {
        if view.poiItems.isEmpty == false && viewModel.isSelected {
            guard let poiItem = view.poiItems[viewModel.cardCurrentIndex] as? MTMapPOIItem else { return }
            view.select(poiItem, animated: true)
            view.setMapCenter(poiItem.mapPoint, animated: true)
        }
    }
    
    func moveMapMyLocation(_ view: MTMapView) {
        viewModel.mtMapPoint
            .sink(receiveValue: { view.setMapCenter($0, zoomLevel: .zero, animated: true) })
            .store(in: &viewModel.cancelBag)
    }
    
    // MARK: - Coordinator
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel: viewModel)
    }
    
    class Coordinator: NSObject, MTMapViewDelegate {
        let viewModel: MainViewModel
        
        init(viewModel: MainViewModel) {
            self.viewModel = viewModel
        }
        
        // 마커 선택됐을 때
        func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
            viewModel.slideCard(poiItem.tag)
            return false
        }
        
        // 지도 터치했을 때
        func mapView(_ mapView: MTMapView!, singleTapOn mapPoint: MTMapPoint!) {
            viewModel.isSelected = false
        }
    }
}
