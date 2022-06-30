//
//  KakaoRepository.swift
//  Gollabab
//
//  Created by Harry on 2022/05/19.
//

import Combine
import Alamofire

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
    private let headers: HTTPHeaders = [
        "Authorization" : "KakaoAK 7a6540ca6236f8c3485109a284cd0e9c"
    ]
    
    func fetchPlace(mandatoryParam: String, lat: String, lon: String, type: SearchType) -> AnyPublisher<KakaoResponse, Error> {
        let param: [String : String] = [
            type.mandatoryParam() : mandatoryParam,
            "x" : lon,
            "y" : lat,
            "radius" : "1000"
        ]
        
        return AF.request(type.url(), method: .get, parameters: param, headers: headers)
            .publishDecodable(type: KakaoResponse.self)
            .value()
            .mapError({ (afError: AFError) in
                return afError as Error
            })
            .eraseToAnyPublisher()
        
        // URLSession
//        var urlComponents = URLComponents(string: type.url())!
//
//        urlComponents.queryItems = param.map { URLQueryItem(name: $0.key, value: $0.value) }
//
//        print("parameters = \(urlComponents.queryItems)")
//
//        let url = urlComponents.url!
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//        urlRequest.headers = headers
//
//        print("URLRequest = \(urlRequest)")
//        print("URLRequest.headers = \(urlRequest.headers)")
//
//
//        return URLSession.shared.dataTaskPublisher(for: urlRequest)
//            .map(\.data)
//            .decode(type: TestPlace.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
    }
}
