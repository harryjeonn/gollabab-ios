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
}
