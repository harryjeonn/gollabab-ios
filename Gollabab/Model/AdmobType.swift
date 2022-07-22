//
//  AdmobType.swift
//  Gollabab
//
//  Created by Harry on 2022/07/22.
//

import Foundation

enum AdmobType {
    case banner
    case full
    case testBanner
    case testFull
    
    func adUnitID() -> String {
        switch self {
        case .banner:
            return "ca-app-pub-6497545219748270/8338511980"
        case .full:
            return "ca-app-pub-6497545219748270/9142944302"
        case .testBanner:
            return "ca-app-pub-3940256099942544/6300978111"
        case .testFull:
            return "ca-app-pub-3940256099942544/4411468910"
        }
    }
}
