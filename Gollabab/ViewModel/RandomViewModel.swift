//
//  RandomViewModel.swift
//  Gollabab
//
//  Created by Harry on 2022/07/08.
//

import Combine
import SwiftUI

class RandomViewModel: ObservableObject {
    @Published var selectedItem: [CategoryType] = []
    @Published var isSelected: Bool = false
    
    func isDisable(_ item: CategoryType) -> Bool {
        return isSelected == false && item != .all || isSelected == true && item == .all || isSelected == true && selectedItem.contains(item) == false
    }
    
    func selectItem(_ item: CategoryType) {
        if item == .all {
            // 전체선택
            isSelected = false
            selectedItem.removeAll()
        } else if selectedItem.contains(item) {
            // 선택해제
            selectedItem.removeAll(where: { $0 == item })
        } else {
            // 선택
            isSelected = true
            selectedItem.append(item)
        }
        
        if selectedItem.isEmpty {
            isSelected = false
        }
    }
}
