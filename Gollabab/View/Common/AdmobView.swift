//
//  AdmobView.swift
//  Gollabab
//
//  Created by Harry on 2022/07/22.
//

import SwiftUI
import GoogleMobileAds

struct AdmobView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        let bannerSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)
        let bannerView = GADBannerView(adSize: bannerSize)
        
        bannerView.adUnitID = AdmobType.banner.adUnitID()
        bannerView.rootViewController = vc
        bannerView.load(GADRequest())
        
        vc.view.addSubview(bannerView)
        vc.view.frame = CGRect(origin: .zero, size: bannerSize.size)
        
        return vc
    }
    
    func updateUIViewController(_ viewController: UIViewController, context: Context) {
    }
}
