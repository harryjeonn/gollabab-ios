//
//  RandomViewModel.swift
//  Gollabab
//
//  Created by Harry on 2022/07/08.
//

import Combine
import SwiftUI

class RandomViewModel: ObservableObject {
    @Published var selectedItem: [CategoryType] = [.korean]
    @Published var isSelectedAll: Bool = false
    
    func isDisable(_ item: CategoryType) -> Bool {
        return selectedItem.contains(item) == false || isSelectedAll == false && item == .all
    }
    
    func selectItem(_ item: CategoryType) {
        isSelectedAll = false
        
        if item == .all {
            // 전체선택
            if selectedItem == CategoryType.allCases {
                selectedItem = [.korean]
            } else {
                selectAll()
            }
        } else if selectedItem.contains(item) {
            // 선택해제
            selectedItem.removeAll(where: { $0 == item })
        } else {
            // 선택
            selectedItem.append(item)
        }
        
        if checkSelectedItem() {
            selectAll()
        }
    }
    
    func selectAll() {
        selectedItem = CategoryType.allCases
        isSelectedAll = true
    }
    
    func checkSelectedItem() -> Bool {
        return sortItem(selectedItem) == sortItem(CategoryType.allCases)
    }
    
    func sortItem(_ item: [CategoryType]) -> [CategoryType] {
        return item
            .filter { $0 != .all }
            .sorted(by: { $0.hashValue < $1.hashValue })
    }
}
