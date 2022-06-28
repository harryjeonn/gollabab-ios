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
        setupMapView(view)
        moveMapMyLocation(view)
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: MTMapView, context: Context) {
        if uiView.poiItems.isEmpty {
            let poiItems = viewModel.createPoiItems()
            poiItems.forEach { item in
                item.customCalloutBalloonView = UIView()
            }
            
            uiView.addPOIItems(poiItems)
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
            // 조건처리안하면 계속 viewModel.currentIndex를 바꾸어서 화면이 나오지 않음
            withAnimation {
                if viewModel.currentIndex != poiItem.tag {
                    viewModel.slideCard(poiItem.tag)
                }
            }
            return true
        }
        
        // 말풍선 터치했을 때
        func mapView(_ mapView: MTMapView!, touchedCalloutBalloonOf poiItem: MTMapPOIItem!) {
            print(viewModel.places[poiItem.tag].placeUrl)
            viewModel.showSafari.toggle()
        }
        
        // 지도 터치했을 때
        func mapView(_ mapView: MTMapView!, singleTapOn mapPoint: MTMapPoint!) {
            // TODO: - 키보드 내리기
            
        }
    }
}
