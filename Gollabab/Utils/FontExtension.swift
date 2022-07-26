//
//  FontExtension.swift
//  Gollabab
//
//  Created by Harry on 2022/06/15.
//

import SwiftUI

extension Font {
    static func eliceBold(size: CGFloat) -> Font {
        return Font.custom("EliceDigitalBaeumOTF-Bd", fixedSize: size)
    }
    
    static func elice(size: CGFloat) -> Font {
        return Font.custom("EliceDigitalBaeumOTF", fixedSize: size)
    }
    
    static func eliceP1() -> Font {
        return Font.custom("EliceDigitalBaeumOTF-Bd", fixedSize: 18)
    }
    
    static func eliceP2() -> Font {
        return Font.custom("EliceDigitalBaeumOTF-Bd", fixedSize: 17)
    }
    
    static func eliceP2Regular() -> Font {
        return Font.custom("EliceDigitalBaeumOTF", fixedSize: 17)
    }
    
    static func eliceP3() -> Font {
        return Font.custom("EliceDigitalBaeumOTF", fixedSize: 16)
    }
    
    static func eliceP4() -> Font {
        return Font.custom("EliceDigitalBaeumOTF", fixedSize: 15)
    }
    
    static func eliceCaption() -> Font {
        return Font.custom("EliceDigitalBaeumOTF", fixedSize: 14)
    }
    
    static func eliceCaptionSmall() -> Font {
        return Font.custom("EliceDigitalBaeumOTF", fixedSize: 12)
    }
    
    static func aggroTitle() -> Font {
        return Font.custom("OTSBAggroM", fixedSize: 36)
    }
    
    static func aggroBold(_ size: CGFloat) -> Font {
        return Font.custom("OTSBAggroB", fixedSize: size)
    }
}
