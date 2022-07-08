//
//  RandomAnimationView.swift
//  Gollabab
//
//  Created by Harry on 2022/07/08.
//

import SwiftUI

struct RandomAnimationView: View {
    @ObservedObject var viewModel: RandomViewModel
    
    var body: some View {
        ForEach(viewModel.selectedItem, id: \.self) { item in
            Text(item.rawValue)
        }
    }
}

struct RandomAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        RandomAnimationView(viewModel: RandomViewModel())
    }
}
