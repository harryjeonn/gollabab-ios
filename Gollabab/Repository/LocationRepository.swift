//
//  LocationRepository.swift
//  Gollabab
//
//  Created by Harry on 2022/05/26.
//

import CoreLocation
import Combine

class LocationRepository: NSObject {
    private var locationManager = CLLocationManager()
    private var myLocationModel = MyLocationModel()
    
    var authorization = PassthroughSubject<CLAuthorizationStatus, Never>()
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        storeLocation()
        
        authorization.send(locationManager.authorizationStatus)
    }
    
    func storeLocation() {
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
    
    func updateLocation(_ location: MTMapPoint) {
        myLocationModel.lat = location.mapPointGeo().latitude
        myLocationModel.lon = location.mapPointGeo().longitude
    }
}

extension LocationRepository: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorization.send(manager.authorizationStatus)
    }
}
