//
//  MainViewModel.swift
//  Gollabab
//
//  Created by Harry on 2022/05/19.
//

import Combine
import SwiftUI

class MainViewModel: ObservableObject {
    private let service = MainService()
    private let userDefaultsRepo = UserDefaultsRepository()
    var cancelBag = Set<AnyCancellable>()
    
    @Published var places: [PlaceModel] = []
    @Published var cardCurrentIndex: Int = 0
    @Published var categoryCurrentIndex: Int = 0
    @Published var showSafari: Bool = false
    @Published var isList: Bool = false
    @Published var isEditing: Bool = false
    @Published var isCardSelectedState: Bool = true
    @Published var isCategorySelectedState: Bool = true
    
    @Published var recentKeyword: [String] = []
    @Published var keyword: String = ""
    
    var mtMapPoint = PassthroughSubject<MTMapPoint, Never>()
    var poiItems = PassthroughSubject<[MTMapPOIItem], Never>()
    var selectedPoiItemIndex = PassthroughSubject<Int, Never>()
    var touchedIndex: Int = 0
    
    init() {
        checkPermisson()
        setupLocation()
    }
    
    // MARK: - 권한체크
    func checkPermisson() {
        service.checkPermission()
            .filter { $0 == true }
            .sink(receiveValue: { [weak self] _ in
                self?.fetchPlace(.all)
                self?.getMapPoint()
            })
            .store(in: &cancelBag)
    }
    
    // MARK: - API 호출
    func fetchPlace(_ type: CategoryType) {
        cardCurrentIndex = 0
        isCategorySelectedState = true
        service.fetchPlace(type)
            .sink(receiveCompletion: { print("fetchPlace completion: \($0)") },
                  receiveValue: { [weak self] value in
                self?.places = value
                self?.createPoiItems()
            })
            .store(in: &cancelBag)
    }
    
    func searchPlace() {
        cardCurrentIndex = 0
        isCategorySelectedState = false
        service.searchPlace(keyword)
            .sink(receiveCompletion: { print("searchPlace completion: \($0)") },
                  receiveValue: { [weak self] value in
                self?.places = value
                self?.createPoiItems()
                self?.saveSearchKeyword()
            })
            .store(in: &cancelBag)
    }
    
    // MARK: - 지도
    func setupLocation() {
        service.setupLocation()
    }

    func getMapPoint() {
        let myLocation = service.getLocation()
        let geoCoord = MTMapPointGeo(latitude: myLocation.lat!, longitude: myLocation.lon!)
        mtMapPoint.send(MTMapPoint(geoCoord: geoCoord))
    }
    
    func createPoiItems() {
        var items: [MTMapPOIItem] = []
        places.enumerated().forEach({ index, place in
            let pin = MTMapPOIItem()
            pin.itemName = place.placeName
            let coord = MTMapPointGeo(latitude: Double(place.latY)!, longitude: Double(place.lonX)!)
            pin.mapPoint = MTMapPoint(geoCoord: coord)
            pin.showAnimationType = .springFromGround
            pin.markerType = .customImage
            pin.markerSelectedType = .customImage
            pin.customImageName = "pin_default"
            pin.customSelectedImageName = "pin_select"
            
            pin.tag = index
            
            items.append(pin)
        })
        
        poiItems.send(items)
    }
    
    // MARK: - 카드, 리스트, 카테고리
    func createPlaceCard(place: PlaceModel, index: Int) -> CardContentView {
        return CardContentView(viewModel: self, placeModel: place, index: index)
    }
    
    func createPlaceList(place: PlaceModel, index: Int) -> ListContentView {
        return ListContentView(viewModel: self, placeModel: place, index: index)
    }
    
    func isSelectedCard(_ index: Int) -> Bool {
        return cardCurrentIndex == index && isCardSelectedState
    }
    
    func isSelectedCategory(_ index: Int) -> Bool {
        return categoryCurrentIndex == index && isCategorySelectedState
    }
    
    func splitedCategory(_ category: String) -> [String.SubSequence] {
        var splitedStr = category.split(separator: ">")
        splitedStr.removeFirst()
        
        return splitedStr
    }
    
    func convertCategory(_ category: String) -> String {
        return splitedCategory(category)
            .map { $0.components(separatedBy: .whitespaces).joined() }
            .map { "#\($0) " }
            .joined()
    }
    
    func getCategoryImageName(_ category: String) -> String {
        let splitedStr = splitedCategory(category)
        let str = String(splitedStr[0].components(separatedBy: .whitespaces).joined())
        
        guard let type = CategoryType(rawValue: str) else { return "icon_other" }
        
        return type.image()
    }
    
    func getURL() -> URL {
        if let url = URL(string: places[touchedIndex].placeUrl) {
            return url
        } else {
            return URL(string: "https://www.daum.net")!
        }
    }
    
    func callToPlace(_ phone: String) {
        let telephone = "tel://"
        let formattedString = telephone + phone
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
    }
    
    func slideCard(_ idx: Int) {
        withAnimation {
            cardCurrentIndex = idx
        }
        isCardSelectedState = true
        selectedPoiItemIndex.send(idx)
    }
    
    // MARK: - 최근 검색
    func fetchRecentSearch() {
        recentKeyword = userDefaultsRepo.loadSearchKeyword()
    }
    
    func deleteAll() {
        userDefaultsRepo.deleteAllKeyword()
        fetchRecentSearch()
    }
    
    func recentKeywordClicked(_ keyword: String) {
        self.keyword = keyword
        searchPlace()
        dismissRecentSearchView()
    }
    
    func saveSearchKeyword() {
        userDefaultsRepo.saveSearchKeyword(keyword)
    }
    
    func deleteSearchKeyword(_ indexSet: IndexSet) {
        recentKeyword.remove(atOffsets: indexSet)
        userDefaultsRepo.saveRecentKeyword(recentKeyword)
    }
    
    func dismissRecentSearchView() {
        isEditing = false
        UIApplication.hideKeyboard()
    }
}
