//
//  AdmobType.swift
//  Gollabab
//
//  Created by Harry on 2022/07/22.
//

import Foundation

enum AdmobType {
    case card
    case list
    case front
    case testBanner
    
    func adUnitID() -> String {
        switch self {
        case .card:
            return "ca-app-pub-6497545219748270/9648511964"
        case .list:
            return "ca-app-pub-6497545219748270/8338511980"
        case .front:
            return "ca-app-pub-6497545219748270/9414609028"
        case .testBanner:
            return "ca-app-pub-3940256099942544/6300978111"
        }
    }
}
