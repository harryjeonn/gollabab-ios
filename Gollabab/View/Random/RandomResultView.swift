//
//  RandomResultView.swift
//  Gollabab
//
//  Created by Harry on 2022/07/15.
//

import SwiftUI

struct RandomResultView: View {
    @ObservedObject var viewModel: RandomViewModel
    
    var body: some View {
        ZStack {
            CustomBackButton(viewModel: viewModel)
                .zIndex(999)
            
        }
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
        .background(Color.text300)
        .onDisappear {
            viewModel.isNavigationActive = false
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct RandomResultView_Previews: PreviewProvider {
    static var previews: some View {
        RandomResultView(viewModel: RandomViewModel())
    }
}
