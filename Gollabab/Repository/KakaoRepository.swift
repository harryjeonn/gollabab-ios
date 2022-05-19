//
//  KakaoRepository.swift
//  Gollabab
//
//  Created by Harry on 2022/05/19.
//

import RxSwift
import Alamofire
import RxAlamofire
import SwiftyJSON

enum SearchType {
    case keyword
    case category
    
    func url() -> String {
        switch self {
        case .keyword:
            return "https://dapi.kakao.com/v2/local/search/keyword.json"
        case .category:
            return "https://dapi.kakao.com/v2/local/search/category.json"
        }
    }
    
    func mandatoryParam() -> String {
        switch self {
        case .keyword:
            return "query"
        case .category:
            return "category_group_code"
        }
    }
}

class KakaoRepository {
    // 주변 식당 정보 가져오기
    private let header: HTTPHeaders = [
        "Authorization" : "KakaoAK 7a6540ca6236f8c3485109a284cd0e9c"
    ]
    
    func fetchPlace(mandatoryParam: String, lat: String, lon: String, type: SearchType) -> Observable<[PlaceModel]?> {
        let url = type.url()
        var range = UserDefaults.standard.float(forKey: "searchRange")
        if range == 0 {
            range = 300
        }
        
        let param: [String : Any] = [
            type.mandatoryParam() : mandatoryParam,
            "x" : lon,
            "y" : lat,
            "radius" : range
        ]
        
        return RxAlamofire
            .requestJSON(.get, url, parameters: param, headers: header)
            .debug()
            .map { resp, json -> [PlaceModel]? in
                switch resp.statusCode {
                case 200..<300:
                    var places = [PlaceModel]()
                    if let documents = JSON(json)["documents"].array {
                        for item in documents {
                            let placeName = item["place_name"].string ?? ""
                            let addressName = item["address_name"].string ?? ""
                            let latY = item["y"].string ?? ""
                            let lonX = item["x"].string ?? ""
                            let distance = item["distance"].string ?? ""
                            let phone = item["phone"].string ?? ""
                            let placeUrl = item["place_url"].string ?? ""
                            let categoryName = item["category_name"].string ?? ""
                            places.append(PlaceModel(placeName: placeName, addressName: addressName, latY: latY, lonX: lonX, distance: distance, phone: phone, placeUrl: placeUrl, categoryName: categoryName))
                        }
                    }
                    return places
                default:
                    return nil
                }
            }
    }
}
