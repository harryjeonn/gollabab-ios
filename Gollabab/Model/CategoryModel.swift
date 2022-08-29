//
//  CategoryModel.swift
//  Gollabab
//
//  Created by Harry on 2022/06/28.
//

import Foundation

enum CategoryType: String, CaseIterable {
    case all = "전체"
    case korean = "한식"
    case chinese = "중식"
    case japanese = "일식"
    case western = "양식"
    case chicken = "치킨"
    case casual = "분식"
    case fastfood = "패스트푸드"
    case asian = "아시아음식"
    case cafe = "카페"
    case snack = "간식"
    case drink = "술집"
    case other
    
    func image() -> String {
        switch self {
        case .all:
            return "icon_all"
        case .korean:
            return "icon_korean"
        case .chinese:
            return "icon_chinese"
        case .japanese:
            return "icon_japanese"
        case .western:
            return "icon_western"
        case .chicken:
            return "icon_chicken"
        case .casual:
            return "icon_casual"
        case .fastfood:
            return "icon_fastfood"
        case .asian:
            return "icon_asian"
        case .cafe:
            return "icon_cafe"
        case .snack:
            return "icon_snack"
        case .drink:
            return "icon_drink"
        case .other:
            return "icon_other"
        }
    }
    
    func lottieName() -> String {
        switch self {
        case .chinese:
            return "card_chinese"
        case .japanese:
            return "card_japanese"
        case .western:
            return "card_western"
        case .chicken:
            return "card_chicken"
        case .casual:
            return "card_casual"
        case .fastfood:
            return "card_fastfood"
        case .asian:
            return "card_asian"
        case .cafe:
            return "card_cafe"
        case .snack:
            return "card_snack"
        default:
            return "card_korean"
        }
    }
}
