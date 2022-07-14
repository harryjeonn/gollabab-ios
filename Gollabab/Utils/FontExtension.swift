//
//  FontExtension.swift
//  Gollabab
//
//  Created by Harry on 2022/06/15.
//

import SwiftUI

extension Font {
    static func eliceBold(size: CGFloat) -> Font {
        return Font.custom("EliceDigitalBaeumOTF-Bd", size: size)
    }
    
    static func elice(size: CGFloat) -> Font {
        return Font.custom("EliceDigitalBaeumOTF", size: size)
    }
    
    static func eliceP1() -> Font {
        return Font.custom("EliceDigitalBaeumOTF-Bd", size: 18)
    }
    
    static func eliceP2() -> Font {
        return Font.custom("EliceDigitalBaeumOTF-Bd", size: 17)
    }
    
    static func eliceP2Regular() -> Font {
        return Font.custom("EliceDigitalBaeumOTF", size: 17)
    }
    
    static func eliceP3() -> Font {
        return Font.custom("EliceDigitalBaeumOTF", size: 16)
    }
    
    static func eliceP4() -> Font {
        return Font.custom("EliceDigitalBaeumOTF", size: 15)
    }
    
    static func eliceCaption() -> Font {
        return Font.custom("EliceDigitalBaeumOTF", size: 14)
    }
    
    static func eliceCaptionSmall() -> Font {
        return Font.custom("EliceDigitalBaeumOTF", size: 12)
    }
}
