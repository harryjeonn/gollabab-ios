//
//  UIApplicationExtension.swift
//  Gollabab
//
//  Created by Harry on 2022/06/29.
//

import Foundation

extension UIApplication {
    static func hideKeyboard() {
        guard let window = self.shared.windows.first else { return }
        window.endEditing(true)
    }
}
