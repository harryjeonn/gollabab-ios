//
//  CardContentView.swift
//  Gollabab
//
//  Created by Harry on 2022/06/02.
//

import SwiftUI

struct CardContentView: View {
    @StateObject var viewModel: MainViewModel
    @State var isSelected: Bool = false
    var placeModel: PlaceModel
    var index: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 12)
            HStack {
                Image(viewModel.getCategoryImageName(placeModel.categoryName))
                    .resizable()
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(placeModel.placeName)
                        .font(.eliceP2())
                        .foregroundColor(viewModel.isSelectedCard(index) ? .primaryBeige : .text200)
                    
                    Text(viewModel.convertCategory(placeModel.categoryName))
                        .foregroundColor(viewModel.isSelectedCard(index) ? .gray700 : .gray500)
                        .font(.eliceCaption())
                }
                Spacer()
            }
            .padding(.leading, 2)
            
            Spacer().frame(height: 8)
            
            HStack(spacing: 0) {
                Spacer().frame(width: 60)
                Image("pin_card")
                    .resizable()
                    .frame(width: 14, height: 14)
                
                Text("\(placeModel.distance)m")
                    .foregroundColor(viewModel.isSelectedCard(index) ? .gray700 : .gray500)
                    .font(.eliceCaption())
                    .padding(.leading, 4)
                
                HStack(spacing: 0) {
                    Image(placeModel.phone.isEmpty ? "phone_disable" : "phone")
                        .resizable()
                        .frame(width: 14, height: 14)
                     
                    Spacer().frame(width: 4)
                    
                    if placeModel.phone.isEmpty {
                        Text("통화불가")
                            .font(.eliceCaption())
                            .foregroundColor(viewModel.isSelectedCard(index) ? .gray700 : .gray500)
                    } else {
                        Text("전화걸기")
                            .foregroundColor(viewModel.isSelectedCard(index) ? .secondaryPink : .primaryRed)
                            .font(.eliceCaption())
                            .underline()
                            .onTapGesture {
                                viewModel.callToPlace(placeModel.phone)
                            }
                    }
                }
                .cornerRadius(30)
                .padding(.leading, 12)
                Spacer()
            }
            Spacer().frame(height: 12)
        }
        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.13)
        .background(viewModel.isSelectedCard(index) ? Color.text300 : Color.white)
        .cornerRadius(16)
        .shadow(color: .cardShadowColor, radius: 3, x: 0, y: 2)
        .onTapGesture {
            viewModel.touchedIndex = index
            viewModel.isSelectedCard(index) ? viewModel.showSafari.toggle() : viewModel.slideCard(index)
        }
    }
}

//struct CardContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardContentView()
//    }
//}
