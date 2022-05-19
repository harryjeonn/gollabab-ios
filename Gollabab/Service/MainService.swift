//
//  MainService.swift
//  Gollabab
//
//  Created by Harry on 2022/05/19.
//

import RxSwift

class MainService {
    private let repository = KakaoRepository()
    
    func fetchPlace() -> Observable<[PlaceModel]?> {
        // repo랑 통신 후 모델을 만들어서 배열로 넘긴다.
        return repository.fetchPlace(mandatoryParam: "식당", lat: "37.38231400000", lon: "127.11961300000", type: .keyword)
            .map({ (items) -> [PlaceModel] in
                var place = [PlaceModel]()
                if let sortedItems = items?.sorted(by: { $0.distance < $1.distance }) {
                    place = sortedItems
                }
                return place
            })
    }
}
