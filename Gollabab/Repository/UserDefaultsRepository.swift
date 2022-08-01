//
//  UserDefaultsRepository.swift
//  Gollabab
//
//  Created by Harry on 2022/06/29.
//

import Foundation

class UserDefaultsRepository {
    private let userDefaults = UserDefaults.standard
    
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
}
