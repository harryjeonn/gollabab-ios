//
//  CustomBackButton.swift
//  Gollabab
//
//  Created by Harry on 2022/07/15.
//

import SwiftUI

struct CustomBackButton: View {
    @ObservedObject var viewModel: RandomViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.isNavigationActive = false
                } label: {
                    Image("arrow_ios_back_outline")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.top, 16)
                        .padding(.leading, 22)
                }
                
                Spacer()
            }
            Spacer()
        }
    }
}

struct CustomBackButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackButton(viewModel: RandomViewModel())
    }
}
