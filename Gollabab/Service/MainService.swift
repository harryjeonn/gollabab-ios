//
//  MainService.swift
//  Gollabab
//
//  Created by Harry on 2022/05/19.
//

import RxSwift

class MainService {
    private let kakaoRepository = KakaoRepository()
    private let locationRepository = LocationRepository()
    
    func fetchPlace() -> Observable<[PlaceModel]?> {
        // repo랑 통신 후 모델을 만들어서 배열로 넘긴다.
        return kakaoRepository.fetchPlace(mandatoryParam: "식당", lat: "\(locationRepository.getLocation().lat!)", lon: "\(locationRepository.getLocation().lon!)", type: .keyword)
            .map({ (items) -> [PlaceModel] in
                var place = [PlaceModel]()
                if let sortedItems = items?.sorted(by: { $0.distance < $1.distance }) {
                    place = sortedItems
                }
                return place
            })
    }
    
    func setupLocation() {
        locationRepository.setupLocation()
    }
    
    func getLocation() -> MyLocationModel {
        return locationRepository.getLocation()
    }
    
    func checkPermission() -> Observable<Bool> {
        return locationRepository.authorization
            .map { status in
                switch status {
                case .authorizedAlways , .authorizedWhenInUse:
                    return true
                case .notDetermined , .denied , .restricted:
                    return false
                default:
                    return false
                }
            }
    }
}
