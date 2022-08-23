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
    
    var isFirst: Bool = true
    var currentMapLat: String = ""
    var currentMapLon: String = ""
    
    func fetchPlace(_ type: CategoryType) -> AnyPublisher<[PlaceModel], Error> {
        let param = type == .all ? "FD6" : type.rawValue
        let searchType: SearchType = type == .all ? .category : .keyword
        
        return fetch(param: param, type: searchType)
    }
    
    func searchPlace(_ keyword: String) -> AnyPublisher<[PlaceModel], Error> {
        return fetch(param: keyword, type: .keyword)
    }
    
    func fetch(param: String, type: SearchType) -> AnyPublisher<[PlaceModel], Error> {
        let lat: String = isFirst ? "\(locationRepository.getLocation().lat!)" : currentMapLat
        let lon: String = isFirst ? "\(locationRepository.getLocation().lon!)" : currentMapLon
        
        return kakaoRepository.fetchPlace(mandatoryParam: param, lat: lat, lon: lon, type: type)
            .map { $0.documents }
            .map { $0.sorted(by: { self.stringToInt($0.distance) < self.stringToInt($1.distance) }) }
            .eraseToAnyPublisher()
    }
    
    func stringToInt(_ distance: String) -> Int {
        return Int(distance) ?? 0
    }
    
    func setupLocation() {
        locationRepository.setupLocation()
    }
    
    func storeLocation() {
        locationRepository.storeLocation()
    }
    
    func updateLocation(_ location: MTMapPoint) {
        locationRepository.updateLocation(location)
    }
    
    func getLocation() -> MyLocationModel {
        return locationRepository.getLocation()
    }
    
    func checkPermission() -> AnyPublisher<LocationStateType, Never> {
        return locationRepository.authorization
            .map { status -> LocationStateType in
                switch status {
                case .authorizedAlways, .authorizedWhenInUse:
                    return .allow
                case .denied:
                    return .notAllow
                default:
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
