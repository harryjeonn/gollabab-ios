//
//  MainViewModel.swift
//  Gollabab
//
//  Created by Harry on 2022/05/19.
//

import RxSwift

class MainViewModel: ObservableObject {
    private let service = MainService()
    private var disposeBag = DisposeBag()
    @Published var places: [PlaceModel] = []
    @Published var currentIndex: Int = 0
    @Published var showSafari: Bool = false
    @Published var isList: Bool = false
    var mtMapPoint = PublishSubject<MTMapPoint>()
    
    func checkPermisson() {
        service.checkPermission()
            .filter { $0 == true }
            .subscribe(onNext: { [weak self] _ in
                self?.setupLocation()
                self?.fetchPlace()
                self?.getMapPoint()
            })
            .disposed(by: disposeBag)
    }
    
    func fetchPlace() {
        places.removeAll()
        service.fetchPlace()
            .filter { $0 != nil }
            .subscribe(onNext: { self.places = $0! })
            .disposed(by: disposeBag)
    }
    
    func createPlaceCard(place: PlaceModel, index: Int) -> CardContentView {
        return CardContentView(viewModel: self, placeModel: place, index: index)
    }
    
    func createPlaceList(place: PlaceModel, index: Int) -> ListContentView {
        return ListContentView(viewModel: self, placeModel: place, index: index)
    }
    
    func isSelectedCard(_ index: Int) -> Bool {
        return currentIndex == index
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
        mtMapPoint.onNext(MTMapPoint(geoCoord: geoCoord))
    }
    
    func createPoiItems() -> [MTMapPOIItem] {
        var items = [MTMapPOIItem]()
        
        places.enumerated().forEach({ index, place in
            let pin = MTMapPOIItem()
            pin.itemName = place.placeName
            let coord = MTMapPointGeo(latitude: Double(place.latY)!, longitude: Double(place.lonX)!)
            pin.mapPoint = MTMapPoint(geoCoord: coord)
            pin.markerType = .yellowPin
            pin.showAnimationType = .springFromGround
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
        currentIndex = idx
    }
}
