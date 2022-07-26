//
//  AdmobViewModel.swift
//  Gollabab
//
//  Created by Harry on 2022/07/26.
//

import Foundation
import GoogleMobileAds

class AdmobRepository: NSObject {
    private var interstitialAd: GADInterstitialAd?
    
    override init() {
        super.init()
        loadAd()
    }
    
    func loadAd() {
        let req = GADRequest()
        let id = AdmobType.full.adUnitID()
        GADInterstitialAd.load(withAdUnitID: id, request: req) { interstitialAd, err in
            if let err = err {
                print("Failed to load ad with error: \(err)")
                return
            }
            
            self.interstitialAd = interstitialAd
            self.interstitialAd?.fullScreenContentDelegate = self
        }
    }
    
    func showAd() {
        if let interstitialAd = interstitialAd {
            let root = UIApplication.shared.windows.first?.rootViewController
            interstitialAd.present(fromRootViewController: root!)
        } else {
            print("Ad not ready")
        }
    }
}

extension AdmobRepository: GADFullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        loadAd()
    }
}
