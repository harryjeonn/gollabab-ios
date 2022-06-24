//
//  MainService.swift
//  Gollabab
//
//  Created by Harry on 2022/05/19.
//

import RxSwift
import Combine
import Foundation
import SwiftyJSON

class MainService {
    private let kakaoRepository = KakaoRepository()
    private let locationRepository = LocationRepository()
    
    func fetchAroundPlace() -> AnyPublisher<KakaoResponse, Error> {
        // 원천데이터 가공 후 리턴
        return kakaoRepository.fetchAroundPlace(mandatoryParam: "식당", lat: "\(locationRepository.getLocation().lat!)", lon: "\(locationRepository.getLocation().lon!)", type: .keyword)
    }
    
    func setupLocation() {
        locationRepository.setupLocation()
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
