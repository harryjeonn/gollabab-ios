//
//  PlaceModel.swift
//  Gollabab
//
//  Created by Harry on 2022/05/19.
//

import Foundation

struct KakaoResponse: Codable {
    var meta: Meta
    var documents: [PlaceModel]
}

struct Meta: Codable {
    var totalCount: Int
    var pageableCount: Int
    var isEnd: Bool
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}


struct PlaceModel: Codable {
    var placeName: String
    var addressName: String
    var latY: String
    var lonX: String
    var distance: String
    var phone: String
    var placeUrl: String
    var categoryName: String
    
    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case addressName = "address_name"
        case latY = "y"
        case lonX = "x"
        case distance, phone
        case placeUrl = "place_url"
        case categoryName = "category_name"
    }
}
