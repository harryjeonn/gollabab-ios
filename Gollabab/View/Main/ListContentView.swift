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
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 16)
            
            Text(placeModel.placeName)
                .font(.eliceP2())
                .foregroundColor(.text300)
                .padding(.leading, 22)
                .lineLimit(1)
            
            Spacer().frame(height: 8)
            
            HStack {
                Text(viewModel.convertCategory(placeModel.categoryName))
                    .font(.eliceCaption())
                    .foregroundColor(.gray500)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.leading, 22)
            
            Spacer().frame(height: 24)
            
            HStack(spacing: 0) {
                Image("pin_card")
                    .resizable()
                    .frame(width: 14, height: 14)
                
                Text("\(placeModel.distance)m")
                    .font(.eliceCaption())
                    .foregroundColor(.gray500)
                    .padding(.leading, 4)
                
                Image(placeModel.phone.isEmpty ? "phone_disable" : "phone")
                    .resizable()
                    .frame(width: 14, height: 14)
                    .padding(.leading, 16)
                    .padding(.trailing, 4)
                
                if placeModel.phone.isEmpty {
                    Text("통화불가")
                        .font(.eliceCaption())
                        .foregroundColor(.gray500)
                } else {
                    Text("전화걸기")
                        .font(.eliceCaption())
                        .foregroundColor(.primaryRed)
                        .underline()
                        .onTapGesture {
                            viewModel.callToPlace(placeModel.phone)
                        }
                }
            }
            .padding(.leading, 22)
            
            Spacer().frame(height: 22)
            
            Rectangle()
                .fill(Color.gray800)
                .frame(height: 1)
                .edgesIgnoringSafeArea(.horizontal)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.touchedIndex = index
            viewModel.showSafari.toggle()
        }
    }
}

//struct ListContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListContentView()
//    }
//}
