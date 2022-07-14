//
//  MainService.swift
//  Gollabab
//
//  Created by Harry on 2022/05/19.
//

import Combine
import Foundation

class MainService {
    private let kakaoRepository = KakaoRepository()
    private let locationRepository = LocationRepository()
    
    func fetchPlace(_ type: CategoryType) -> AnyPublisher<[PlaceModel], Error> {
        let param = type == .all ? "FD6" : type.rawValue
        let searchType: SearchType = type == .all ? .category : .keyword
        
        return fetch(param: param, type: searchType)
    }
    
    func searchPlace(_ keyword: String) -> AnyPublisher<[PlaceModel], Error> {
        return fetch(param: keyword, type: .keyword)
    }
    
    func fetch(param: String, type: SearchType) -> AnyPublisher<[PlaceModel], Error> {
        return kakaoRepository.fetchPlace(mandatoryParam: param, lat: "\(locationRepository.getLocation().lat!)", lon: "\(locationRepository.getLocation().lon!)", type: type)
            .map { $0.documents }
            .map { $0.sorted(by: { self.stringToInt($0.distance) < self.stringToInt($1.distance) }) }
            .eraseToAnyPublisher()
    }
    
    func stringToInt(_ distance: String) -> Int {
        guard let int = Int(distance) else { return 0 }
        return int
    }
    
    func setupLocation() {
        locationRepository.setupLocation()
    }
    
    func updateLocation(_ location: MTMapPoint) {
        locationRepository.updateLocation(location)
    }
    
    func getLocation() -> MyLocationModel {
        return locationRepository.getLocation()
    }
    
    func checkPermission() -> AnyPublisher<Bool, Never> {
        return locationRepository.authorization
            .map { status -> Bool in
                switch status {
                case .authorizedAlways , .authorizedWhenInUse:
                    return true
                case .notDetermined , .denied , .restricted:
                    return false
                default:
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
}
