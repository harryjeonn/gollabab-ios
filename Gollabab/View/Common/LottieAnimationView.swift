//
//  LottieAnimationView.swift
//  Gollabab
//
//  Created by Harry on 2022/07/26.
//

import SwiftUI
import Lottie
import UIKit

struct LottieAnimationView: UIViewRepresentable {
    
    var filename: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let animationView = AnimationView()
        
        animationView.animation = Animation.named(filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieAnimationView>) {
    }
    
}
