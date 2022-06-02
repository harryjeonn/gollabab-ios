//
//  CardContentView.swift
//  Gollabab
//
//  Created by Harry on 2022/06/02.
//

import SwiftUI

struct CardContentView: View {
    @ObservedObject var viewModel: MainViewModel
    var placeModel: PlaceModel
    var index: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 12)
            HStack {
                Image(systemName: "xmark")
                    .frame(width: 40, height: 40)
                    .foregroundColor(.red)
                VStack(alignment: .leading, spacing: 4) {
                    Text(placeModel.placeName)
                        .fontWeight(.bold)
                        .font(.system(size: 15))
                        .foregroundColor(viewModel.isSelectedCard(index) ? .selectedTextColor : .textBlackColor)
                        .frame(height: 23)
                        .minimumScaleFactor(0.1)
                    
                    Text(viewModel.convertCategory(placeModel.categoryName))
                        .foregroundColor(viewModel.isSelectedCard(index) ? .selectedTextColor : .textGrayColor)
                        .frame(height: 20)
                        .font(.system(size: 12))
                        .minimumScaleFactor(0.1)
                }
                Spacer()
            }
            .padding(.leading, 12)
            
            Spacer().frame(height: 8)
            
            HStack(spacing: 0) {
                Spacer().frame(width: 60)
                Image(systemName: "pin")
                    .frame(width: 9, height: 11)
                    .foregroundColor(.red)
                
                Text("\(placeModel.distance)m")
                    .foregroundColor(viewModel.isSelectedCard(index) ? .selectedTextColor : .textGrayColor)
                    .frame(height: 20)
                    .font(.system(size: 12))
                    .padding(.leading, 8)
                
                HStack {
                    Image(systemName: "phone.fill")
                        .frame(width: 12, height: 12)
                        .foregroundColor(.white)
                        .padding(.leading, 8)
                    
                    Spacer().frame(width: 4)
                    
                    Text("전화걸기")
                        .foregroundColor(.white)
                        .padding(.trailing, 8)
                        .font(.system(size: 12))
                }
                .frame(height: 24)
                .background(Color.red)
                .cornerRadius(30)
                .padding(.leading, 12)
                Spacer()
            }
            Spacer().frame(height: 12)
        }
    }
}

//struct CardContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardContentView()
//    }
//}
