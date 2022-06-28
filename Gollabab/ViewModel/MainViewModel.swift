//
//  MainViewModel.swift
//  Gollabab
//
//  Created by Harry on 2022/05/19.
//

import Combine
import SwiftUI

class MainViewModel: ObservableObject {
    private let service = MainService()
    var cancelBag = Set<AnyCancellable>()
    
    @Published var places: [PlaceModel] = []
    @Published var cardCurrentIndex: Int = 0
    @Published var categoryCurrenIndex: Int = 0
    @Published var showSafari: Bool = false
    @Published var isList: Bool = false
    
    var mtMapPoint = PassthroughSubject<MTMapPoint, Never>()
    
    func checkPermisson() {
        service.checkPermission()
            .filter { $0 == true }
            .sink(receiveValue: { _ in
                self.setupLocation()
                self.fetchPlace(.all)
                self.getMapPoint()
            })
            .store(in: &cancelBag)
    }
    
    func fetchPlace(_ type: CategoryType) {
        cardCurrentIndex = 0
        service.fetchPlace(type)
            .sink(receiveCompletion: { print("completion: \($0)") },
                  receiveValue: { self.places = $0 })
            .store(in: &cancelBag)
    }
    
    func createPlaceCard(place: PlaceModel, index: Int) -> CardContentView {
        return CardContentView(viewModel: self, placeModel: place, index: index)
    }
    
    func createPlaceList(place: PlaceModel, index: Int) -> ListContentView {
        return ListContentView(viewModel: self, placeModel: place, index: index)
    }
    
    func isSelectedCard(_ index: Int) -> Bool {
        return cardCurrentIndex == index
    }
    
    func isSelectedCategory(_ index: Int) -> Bool {
        return categoryCurrenIndex == index
    }
    
    func getWidth() -> CGFloat {
        return UIScreen.main.bounds.width * 0.8
    }
    
    func setupLocation() {
        service.setupLocation()
    }

    func getMapPoint() {
        let myLocation = service.getLocation()
        let geoCoord = MTMapPointGeo(latitude: myLocation.lat!, longitude: myLocation.lon!)
        mtMapPoint.send(MTMapPoint(geoCoord: geoCoord))
    }
    
    func createPoiItems() -> [MTMapPOIItem] {
        var items = [MTMapPOIItem]()
        
        places.enumerated().forEach({ index, place in
            let pin = MTMapPOIItem()
            pin.itemName = place.placeName
            let coord = MTMapPointGeo(latitude: Double(place.latY)!, longitude: Double(place.lonX)!)
            pin.mapPoint = MTMapPoint(geoCoord: coord)
            pin.showAnimationType = .springFromGround
            pin.markerType = .customImage
            pin.markerSelectedType = .customImage
            pin.customImageName = "pin_default"
            pin.customSelectedImageName = "pin_select"
            
            pin.tag = index
            
            items.append(pin)
        })
        
        return items
    }
    
    func convertCategory(_ category: String) -> String {
        var splitedStr = category.split(separator: ">")
        splitedStr.removeFirst()
        
        return splitedStr
            .map { $0.components(separatedBy: .whitespaces).joined() }
            .map { "#\($0) " }
            .joined()
    }
    
    func callToPlace(_ phone: String) {
        let telephone = "tel://"
        let formattedString = telephone + phone
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
    }
    
    func slideCard(_ idx: Int) {
        cardCurrentIndex = idx
    }
}
