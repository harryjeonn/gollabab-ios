//
//  AdmobView.swift
//  Gollabab
//
//  Created by Harry on 2022/07/22.
//

import SwiftUI
import GoogleMobileAds

struct AdmobView: UIViewControllerRepresentable {
    let admobType: AdmobType
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        checkType(vc)
        
        return vc
    }
    
    func updateUIViewController(_ viewController: UIViewController, context: Context) {
        
    }
    
    func checkType(_ vc: UIViewController) {
        switch admobType {
        case .banner, .testBanner:
            addBannerView(vc)
        case .full, .testFull:
            addFullView(vc)
        }
    }
    
    func addBannerView(_ vc: UIViewController) {
        let bannerSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)
        let bannerView = GADBannerView(adSize: bannerSize)
        
        bannerView.adUnitID = admobType.adUnitID()
        bannerView.rootViewController = vc
        bannerView.load(GADRequest())
        
        vc.view.addSubview(bannerView)
        vc.view.frame = CGRect(origin: .zero, size: bannerSize.size)
    }
    
    func addFullView(_ vc: UIViewController) {
        
    }
}
