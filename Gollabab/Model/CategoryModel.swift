//
//  CategoryModel.swift
//  Gollabab
//
//  Created by Harry on 2022/06/28.
//

import Foundation

enum CategoryType: CaseIterable {
    case all
    case korean
    case chinese
    case japanese
    case western
    case casual
    case fastfood
    case asian
    case cafe
    case snack
    
    func title() -> String {
        switch self {
        case .all:
            return "전체"
        case .korean:
            return "한식"
        case .chinese:
            return "중식"
        case .japanese:
            return "일식"
        case .western:
            return "양식"
        case .casual:
            return "분식"
        case .fastfood:
            return "패스트푸드"
        case .asian:
            return "아시아음식"
        case .cafe:
            return "카페"
        case .snack:
            return "간식"
        }
    }
}
