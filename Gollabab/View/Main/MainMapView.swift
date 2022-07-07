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
    
    let view = MTMapView()
    
    func makeUIView(context: Context) -> MTMapView {
        viewModel.setupLocation()
        setupMapView()
        
        subscribePoiItems()
        subscribeMyLocation()
        subscribeSelectedPoiItem()
        
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: MTMapView, context: Context) {
    }
    
    func subscribePoiItems() {
        viewModel.poiItems
            .sink { items in
                view.removeAllPOIItems()
                view.addPOIItems(items)
                self.selectPoiItem(items.first)
            }.store(in: &viewModel.cancelBag)
    }
    
    func setupMapView() {
        view.baseMapType = .standard
        view.showCurrentLocationMarker = true
        view.currentLocationTrackingMode = .onWithoutHeadingWithoutMapMoving
    }
    
    func subscribeSelectedPoiItem() {
        viewModel.selectedPoiItemIndex
            .sink(receiveValue: { index in
                guard let poiItem = view.poiItems[index] as? MTMapPOIItem else { return }
                deselectPoiItem()
                selectPoiItem(poiItem)
            })
            .store(in: &viewModel.cancelBag)
    }
    
    func deselectPoiItem() {
        view.poiItems.forEach { poiItem in
            let item = poiItem as! MTMapPOIItem
            view.deselect(item)
        }
    }
    
    func selectPoiItem(_ poiItem: MTMapPOIItem?) {
        guard let poiItem = poiItem else { return }
        viewModel.selectedPoiItem = poiItem
        view.select(poiItem, animated: true)
    }
    
    func subscribeMyLocation() {
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
    }
}
