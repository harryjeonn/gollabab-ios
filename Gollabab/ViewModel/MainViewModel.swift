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
    
    @Published var selectionTab: Int = 0
    
    @Published var places: [PlaceModel] = []
    @Published var selectedRandomItems: [CategoryType] = [.korean]
    
    @Published var cardCurrentIndex: Int = 0
    @Published var categoryCurrentIndex: Int = 0
    @Published var moveIndex: Int = 2
    
    @Published var showSafari: Bool = false
    @Published var isList: Bool = false
    @Published var isEditing: Bool = false
    @Published var isCardSelectedState: Bool = true
    @Published var isCategorySelectedState: Bool = true
    @Published var isActiveMyLocation: Bool = true
    
    @Published var isSelectedAll: Bool = false
    @Published var isRandomEmpty: Bool = false
    @Published var isNavigationActive: Bool = false
    @Published var previousIsRandom: Bool = false
    
    @Published var recentKeyword: [String] = []
    @Published var keyword: String = ""
    
    @Published var selectedPoiItem: MTMapPOIItem = MTMapPOIItem()
    
    var mtMapPoint = PassthroughSubject<MTMapPoint, Never>()
    var poiItems = PassthroughSubject<[MTMapPOIItem], Never>()
    var selectedPoiItemIndex = PassthroughSubject<Int, Never>()
    var touchedIndex: Int = 0
    
    var randomPlaces: [PlaceModel] = []
    var randomResult: [PlaceModel] = []
    
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
        
        type == .all ? fetchAll() : fetchCategory(type)
    }
    
    func fetchCategory(_ type: CategoryType) {
        service.fetchPlace(type)
            .sink(receiveCompletion: { print("fetchPlace completion: \($0)") },
                  receiveValue: { [weak self] value in
                self?.places = value
                self?.createPoiItems()
            })
            .store(in: &cancelBag)
    }
    
    func fetchAll() {
        var temp: [PlaceModel] = []
        
        CategoryType.allCases
            .filter { $0 != .all }
            .filter { $0 != .snack }
            .filter { $0 != .cafe }
            .filter { $0 != .other }
            .forEach { category in
                service.fetchPlace(category)
                    .sink(receiveCompletion: { print("fetchPlaceAll completion: \($0)") },
                          receiveValue: { [weak self] value in
                        value.forEach { place in
                            temp.append(place)
                        }
                        self?.randomPlace(temp)
                        self?.createPoiItems()
                    })
                    .store(in: &cancelBag)
            }
    }
    
    func randomPlace(_ orgPlace: [PlaceModel]) {
        var newPlaces = orgPlace.shuffled()
        if newPlaces.count > 30 {
            newPlaces = Array(newPlaces[..<30])
        }
        
        places = newPlaces.sorted(by: { service.stringToInt($0.distance) < service.stringToInt($1.distance) })
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
    
    func updateLocation(_ location: MTMapPoint) {
        service.updateLocation(location)
    }
    
    func getMapPoint() {
        let myLocation = service.getLocation()
        let geoCoord = MTMapPointGeo(latitude: myLocation.lat!, longitude: myLocation.lon!)
        isActiveMyLocation = true
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
    
    func getCategory(_ category: String) -> CategoryType {
        let splitedStr = splitedCategory(category)
        let str = String(splitedStr[0].components(separatedBy: .whitespaces).joined())
        
        guard let type = CategoryType(rawValue: str) else { return .other }
        
        return type
    }
    
    func getURL(_ urlStr: String) -> URL {
        if let url = URL(string: urlStr) {
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
        isActiveMyLocation = false
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
    
    // MARK: - 랜덤
    func isDisable(_ item: CategoryType) -> Bool {
        return selectedRandomItems.contains(item) == false || isSelectedAll == false && item == .all
    }
    
    func selectItem(_ item: CategoryType) {
        isSelectedAll = false
        
        if item == .all {
            // 전체선택
            if selectedRandomItems == CategoryType.allCases.filter({ $0 != .other }) {
                selectedRandomItems = [.korean]
            } else {
                selectAll()
            }
        } else if selectedRandomItems.contains(item) {
            // 선택해제
            selectedRandomItems.removeAll(where: { $0 == item })
        } else {
            // 선택
            selectedRandomItems.append(item)
        }
        
        if checkSelectedItem() {
            selectAll()
        }
    }
    
    func selectAll() {
        selectedRandomItems = CategoryType.allCases.filter { $0 != .other }
        isSelectedAll = true
    }
    
    func checkSelectedItem() -> Bool {
        return sortItem(selectedRandomItems) == sortItem(CategoryType.allCases)
    }
    
    func sortItem(_ item: [CategoryType]) -> [CategoryType] {
        return item
            .filter { $0 != .all }
            .sorted(by: { $0.hashValue < $1.hashValue })
    }
    
    func fetchRandomPlace() {
        randomPlaces.removeAll()
        
        if selectedRandomItems.isEmpty {
            return
        }
        
        selectedRandomItems.enumerated().forEach { index, item in
            service.fetchPlace(item)
                .sink(receiveCompletion: { print("fetchPlace completion: \($0)") },
                      receiveValue: { [weak self] value in
                    value.forEach { place in
                        self?.randomPlaces.append(place)
                    }
                    
                    if index == (self?.selectedRandomItems.count)! - 1 {
                        self?.getRandomPlaces()
                    }
                })
                .store(in: &cancelBag)
        }
    }
    
    // MARK: - Random Animation View
    func getRandomPlaces() {
        isNavigationActive = !randomPlaces.isEmpty
        
        if randomPlaces.isEmpty {
            withAnimation(.easeInOut) {
                isRandomEmpty = true
            }
            return
        } else if randomPlaces.count <= 3 {
            randomResult = randomPlaces
            return
        }
        
        randomResult.removeAll()
        
        while randomResult.count < 3 {
            guard let place = randomPlaces.randomElement() else { return }
            
            if randomResult.contains(place) == false {
                randomResult.append(place)
            }
        }
    }
    
    func retryGetRandomPlaces() {
        for i in 0...randomResult.count - 1 {
            randomPlaces.removeAll(where: { $0.placeUrl == randomResult[i].placeUrl })
        }
        
        getRandomPlaces() 
    }
    
    func startAnimation() {
        moveIndex = 30
    }
    
    // MARK: - Random Result View
    func getMidIndex() -> Int {
        guard randomResult.count != 0 else { return 0 }
        
        return (randomResult.count > 1 ? randomResult.count - 1 : randomResult.count) / 2
    }
    
    func showMapButtonClicked(_ currentIndex: Int) {
        places = randomResult
        createPoiItems()
        selectionTab = 0
        
        isNavigationActive = false
        isCategorySelectedState = false
        
        slideCard(currentIndex)
    }
}
