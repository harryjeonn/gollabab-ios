//
//  ColorExtension.swift
//  Gollabab
//
//  Created by Harry on 2022/06/02.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
    
    
    static let text200 = Color(hex: "282828")
    static let text300 = Color(hex: "282828")
    
    static let primaryBeige = Color(hex: "FDF6E5")
    
    static let primaryRed = Color(hex: "D8412B")
    static let secondaryRed = Color(hex: "EC674E")
    static let selectedRed = Color(hex: "F94D08")
    static let secondaryPink = Color(hex: "FEB0A2")
    
    static let gray100 = Color(hex: "121212")
    static let gray500 = Color(hex: "747474")
    static let gray600 = Color(hex: "959595")
    static let gray700 = Color(hex: "BDBDBD")
    static let gray800 = Color(hex: "F5F5F5")
    
    static let cardShadowColor = Color(hex: "444444").opacity(0.3)
}
