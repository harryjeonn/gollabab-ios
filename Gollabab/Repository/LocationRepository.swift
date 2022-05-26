//
//  LocationRepository.swift
//  Gollabab
//
//  Created by Harry on 2022/05/26.
//

import CoreLocation
import RxSwift

class LocationRepository: NSObject {
    private var locationManager = CLLocationManager()
    private var myLocationModel = MyLocationModel()
    
    var authorization = PublishSubject<CLAuthorizationStatus>()
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if let coordinate = locationManager.location?.coordinate {
            myLocationModel.lat = coordinate.latitude
            myLocationModel.lon = coordinate.longitude
        } else {
            // 기본 위/경도 값 = 서울시청
            myLocationModel.lat = 37.5666805
            myLocationModel.lon = 126.9784147
        }
    }
    
    func getLocation() -> MyLocationModel {
        return myLocationModel
    }
}

extension LocationRepository: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorization.onNext(manager.authorizationStatus)
    }
}
