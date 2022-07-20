//
//  RandomViewModel.swift
//  Gollabab
//
//  Created by Harry on 2022/07/08.
//

import Combine
import SwiftUI

class RandomViewModel: ObservableObject {
    private let service: MainService = MainService()
    var cancelBag = Set<AnyCancellable>()
    
    @Published var places: [PlaceModel] = []
    @Published var selectedItems: [CategoryType] = [.korean]
    @Published var isSelectedAll: Bool = false
    @Published var isNavigationActive: Bool = false
    
    var randomPlaces: [PlaceModel] = []
    
    func isDisable(_ item: CategoryType) -> Bool {
        return selectedItems.contains(item) == false || isSelectedAll == false && item == .all
    }
    
    func selectItem(_ item: CategoryType) {
        isSelectedAll = false
        
        if item == .all {
            // 전체선택
            if selectedItems == CategoryType.allCases {
                selectedItems = [.korean]
            } else {
                selectAll()
            }
        } else if selectedItems.contains(item) {
            // 선택해제
            selectedItems.removeAll(where: { $0 == item })
        } else {
            // 선택
            selectedItems.append(item)
        }
        
        if checkSelectedItem() {
            selectAll()
        }
    }
    
    func selectAll() {
        selectedItems = CategoryType.allCases
        isSelectedAll = true
    }
    
    func checkSelectedItem() -> Bool {
        return sortItem(selectedItems) == sortItem(CategoryType.allCases)
    }
    
    func sortItem(_ item: [CategoryType]) -> [CategoryType] {
        return item
            .filter { $0 != .all }
            .sorted(by: { $0.hashValue < $1.hashValue })
    }
    
    func fetchPlace() {
        service.setupLocation()
        
        places.removeAll()
        
        if selectedItems.isEmpty {
            selectedItems = CategoryType.allCases
        }
        
        selectedItems.enumerated().forEach { index, item in
            service.fetchPlace(item)
                .sink(receiveCompletion: { print("fetchPlace completion: \($0)") },
                      receiveValue: { [weak self] value in
                    value.forEach { place in
                        self?.places.append(place)
                    }
                    
                    if index == (self?.selectedItems.count)! - 1 {
                        self?.getRandomPlaces()
                    }
                })
                .store(in: &cancelBag)
        }
    }
    
    // MARK: - Random Animation View
    func getRandomPlaces() {
        randomPlaces.removeAll()
        
        if places.count <= 3 {
            randomPlaces = places
            return
        }
        
        while randomPlaces.count < 3 {
            guard let place = places.randomElement() else { return }
            
            if randomPlaces.contains(place) == false {
                randomPlaces.append(place)
            }
        }
    }
    
    // MARK: - Random Result View
    func getMidIndex() -> Int {
        guard randomPlaces.count != 0 else { return 0 }
        
        return (randomPlaces.count > 1 ? randomPlaces.count - 1 : randomPlaces.count) / 2
    }
}
