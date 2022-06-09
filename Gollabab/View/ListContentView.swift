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
                .fontWeight(.bold)
                .font(.system(size: 15))
                .frame(height: 23)
                .padding(.leading, 22)
            
            Spacer().frame(height: 4)
            
            HStack {
                Text(viewModel.convertCategory(placeModel.categoryName))
                    .foregroundColor(.textGrayColor)
                    .font(.system(size: 12))
                    .frame(height: 20)
                
                Spacer()
            }
            .padding(.leading, 22)
            
            Spacer().frame(height: 10)
            
            HStack {
                Image(systemName: "pin")
                    .frame(width: 9, height: 11)
                    .foregroundColor(.red)
                
                Text("\(placeModel.distance)m")
                    .foregroundColor(.textGrayColor)
                    .font(.system(size: 12))
                    .frame(height: 20)
                
                Image(systemName: "phone.fill")
                    .frame(width: 12, height: 12)
                    .foregroundColor(.red)
                    .padding(.leading, 8)
                
                Text(placeModel.phone)
                    .foregroundColor(.textGrayColor)
                    .font(.system(size: 12))
                    .underline()
                    .frame(height: 20)
                    .onTapGesture {
                        viewModel.callToPlace(placeModel.phone)
                    }
            }
            .padding(.leading, 22)
            
            Spacer().frame(height: 18)
            
            Rectangle()
                .fill(Color.dividerColor)
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
