//
//  ListContentView.swift
//  Gollabab
//
//  Created by Harry on 2022/06/09.
//

import SwiftUI

struct ListContentView: View {
    @ObservedObject var viewModel: MainViewModel
    var placeModel: PlaceModel
    var index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 12)
            
            Text(placeModel.placeName)
                .font(.eliceP2())
                .foregroundColor(.text300)
                .frame(height: 23)
                .padding(.leading, 22)
            
            Spacer().frame(height: 4)
            
            HStack {
                Text(viewModel.convertCategory(placeModel.categoryName))
                    .font(.eliceCaption())
                    .foregroundColor(.gray500)
                    .frame(height: 20)
                
                Spacer()
            }
            .padding(.leading, 22)
            
            Spacer().frame(height: 10)
            
            HStack {
                Image("pin_card")
                    .frame(width: 12, height: 12)
                    .foregroundColor(.red)
                
                Text("\(placeModel.distance)m")
                    .font(.eliceCaption())
                    .foregroundColor(.gray500)
                    .frame(height: 20)
                
                Image("phone")
                    .frame(width: 12, height: 12)
                    .foregroundColor(.red)
                    .padding(.leading, 8)
                
                if placeModel.phone.isEmpty {
                    Text("전화번호가 없다밥")
                        .font(.eliceCaption())
                        .foregroundColor(.gray500)
                } else {
                    Text("전화걸기")
                        .font(.eliceCaption())
                        .foregroundColor(.primaryRed)
                        .underline()
                        .frame(height: 20)
                        .onTapGesture {
                            viewModel.callToPlace(placeModel.phone)
                        }
                }
            }
            .padding(.leading, 22)
            
            Spacer().frame(height: 18)
            
            Rectangle()
                .fill(Color.gray800)
                .frame(height: 1)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
}

//struct ListContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListContentView()
//    }
//}
