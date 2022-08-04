//
//  GameViewModel.swift
//  Gollabab
//
//  Created by Harry on 2022/08/04.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var bombCount: Int = 1
    @Published var selectedBombCount: Int = 0
    
    @Published var isGame: Bool = false
    var gameItem: [String] = []
    
    func plusBombCount() {
        if bombCount < 8 {
            bombCount += 1
        }
    }
    
    func minusBombCount() {
        if bombCount > 1 {
            bombCount -= 1
        }
    }
    
    func makeGameItem() {
        gameItem = Array(0...8).map { "\($0)번 통과" }
        
        for count in 0..<bombCount {
            gameItem[count] = "\(count)번 꽝!!"
        }
        
        gameItem.shuffle()
    }
    
    func startGame() {
        makeGameItem()
        isGame = true
        selectedBombCount = 0
    }
    
    func stopGame() {
        isGame = false
    }
    
    func isAllSelectedBomb() -> Bool {
        return selectedBombCount == bombCount
    }
}
