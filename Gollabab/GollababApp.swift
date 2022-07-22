//
//  GollababApp.swift
//  Gollabab
//
//  Created by 전현성 on 2022/04/28.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency

@main
struct GollababApp: App {
    
    init() {
        // 구글 Admob 초기화
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        // 앱 추적 승인 요청 화면 띄우기
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in })
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
