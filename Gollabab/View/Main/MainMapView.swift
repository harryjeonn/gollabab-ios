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
        let view = MTMapView()
        viewModel.setupLocation()
        setupMapView(view)
        
        subscribePoiItems(view)
        subscribeMyLocation(view)
        subscribeSelectedPoiItem(view)
        
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: MTMapView, context: Context) {
    }
    
    func subscribePoiItems(_ view: MTMapView) {
        viewModel.poiItems
            .sink { items in
                view.removeAllPOIItems()
                view.addPOIItems(items)
                self.selectPoiItem(poiItem: items.first, view: view)
            }.store(in: &viewModel.cancelBag)
    }
    
    func setupMapView(_ view: MTMapView) {
        view.baseMapType = .standard
        view.showCurrentLocationMarker = true
        view.currentLocationTrackingMode = .onWithoutHeadingWithoutMapMoving
        view.setZoomLevel(.zero, animated: true)
    }
    
    func subscribeSelectedPoiItem(_ view: MTMapView) {
        viewModel.selectedPoiItemIndex
            .sink(receiveValue: { index in
                guard let poiItem = view.poiItems[index] as? MTMapPOIItem else { return }
                deselectPoiItem(view)
                selectPoiItem(poiItem: poiItem, view: view)
            })
            .store(in: &viewModel.cancelBag)
    }
    
    func deselectPoiItem(_ view: MTMapView) {
        view.poiItems.forEach { poiItem in
            let item = poiItem as! MTMapPOIItem
            view.deselect(item)
        }
    }
    
    func selectPoiItem(poiItem: MTMapPOIItem?, view: MTMapView) {
        guard let poiItem = poiItem else { return }
        viewModel.selectedPoiItem = poiItem
        view.select(poiItem, animated: true)
    }
    
    func subscribeMyLocation(_ view: MTMapView) {
        viewModel.mtMapPoint
            .sink(receiveValue: { view.setMapCenter($0, animated: true) })
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
        
        func deselectPoiItem(_ mapView: MTMapView) {
            mapView.poiItems.forEach { poiItem in
                let item = poiItem as! MTMapPOIItem
                mapView.deselect(item)
            }
        }
        
        // 마커 선택됐을 때
        func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
            deselectPoiItem(mapView)
            
            withAnimation {
                viewModel.cardCurrentIndex = poiItem.tag
            }
            
            viewModel.isCardSelectedState = true
            viewModel.isActiveMyLocation = false
            viewModel.selectedPoiItem = poiItem
            
            mapView.setMapCenter(poiItem.mapPoint, animated: true)
            return false
        }
        
        // 지도 터치했을 때
        func mapView(_ mapView: MTMapView!, singleTapOn mapPoint: MTMapPoint!) {
            deselectPoiItem(mapView)
            viewModel.isCardSelectedState = false
        }
        
        // 지도 중심 좌표 변경 됐을 때
        func mapView(_ mapView: MTMapView!, centerPointMovedTo mapCenterPoint: MTMapPoint!) {
            viewModel.isActiveMyLocation = false
        }
        
        // 현 위치 변경 됐을 때
        func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
            viewModel.updateLocation(location)
        }
    }
}
