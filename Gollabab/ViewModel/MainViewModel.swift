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
    
    func createPlaceCard(_ place: PlaceModel) -> PlaceCardView {
        return PlaceCardView(placeModel: place)
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
}
