//
//  UserDefaultsRepository.swift
//  Gollabab
//
//  Created by Harry on 2022/06/29.
//

import Foundation

class UserDefaultsRepository {
    static let shared = UserDefaultsRepository()
    
    private let userDefaults = UserDefaults.standard
    private let admobRepo = AdmobRepository()
    
    func saveSearchKeyword(_ keyword: String) {
        deleteSearchKeyword(keyword)
        var recentKeyword = loadSearchKeyword()
        recentKeyword.insert(keyword, at: 0)
        
        userDefaults.set(recentKeyword, forKey: "recentKeyword")
    }
    
    func saveRecentKeyword(_ recentKeyword: [String]) {
        userDefaults.set(recentKeyword, forKey: "recentKeyword")
    }
    
    func loadSearchKeyword() -> [String] {
        if let recentKeyword = userDefaults.array(forKey: "recentKeyword") as? [String] {
            if recentKeyword.count > 30 {
                return Array(recentKeyword[0..<30])
            }
            return recentKeyword
        } else {
            return []
        }
    }
    
    func deleteSearchKeyword(_ keyword: String) {
        var recentKeyword = loadSearchKeyword()
        
        recentKeyword.enumerated().forEach { idx, word in
            if word == keyword {
                recentKeyword.remove(at: idx)
            }
        }
        
        userDefaults.set(recentKeyword, forKey: "recentKeyword")
    }
    
    func deleteAllKeyword() {
        userDefaults.set([], forKey: "recentKeyword")
    }
    
    func plusAdsCount() {
        var count = loadAdsCount()
        count += 1
        
        UserDefaults.standard.set(count, forKey: "adsCount")
    }
    
    func loadAdsCount() -> Int {
        return UserDefaults.standard.integer(forKey: "adsCount")
    }
    
    func checkAdsCount() {
        let count = loadAdsCount()
        if count % 10 == 0 && count > 0 {
            admobRepo.showAd()
            plusAdsCount()
        }
    }
}
