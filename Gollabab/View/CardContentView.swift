//
//  CardContentView.swift
//  Gollabab
//
//  Created by Harry on 2022/06/02.
//

import SwiftUI

struct CardContentView: View {
    @ObservedObject var viewModel: MainViewModel
    @State var isSelected: Bool = false
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
                        .font(.eliceP2())
                        .foregroundColor(.text200)
                        .frame(height: 23)
                        .minimumScaleFactor(0.1)
                    
                    Text(viewModel.convertCategory(placeModel.categoryName))
                        .foregroundColor(.gray500)
                        .frame(height: 20)
                        .font(.eliceCaption())
                        .minimumScaleFactor(0.1)
                }
                Spacer()
            }
            .padding(.leading, 12)
            
            Spacer().frame(height: 8)
            
            HStack(spacing: 0) {
                Spacer().frame(width: 60)
                Image("pin_card")
                    .frame(width: 10, height: 10)
                    .foregroundColor(.red)
                
                Text("\(placeModel.distance)m")
                    .foregroundColor(.gray500)
                    .frame(height: 20)
                    .font(.eliceCaption())
                    .padding(.leading, 8)
                
                HStack {
                    Image("phone")
                        .frame(width: 12, height: 12)
                        .padding(.leading, 8)
                     
                    Spacer().frame(width: 4)
                    
                    if placeModel.phone.isEmpty {
                        Text("전화번호가 없다밥")
                            .font(.eliceCaption())
                            .foregroundColor(.gray500)
                    } else {
                        Text("전화걸기")
                            .foregroundColor(.primaryRed)
                            .font(.eliceCaption())
                            .underline()
                            .padding(.trailing, 8)
                            .onTapGesture {
                                viewModel.callToPlace(placeModel.phone)
                            }
                    }
                }
                .frame(height: 24)
                .cornerRadius(30)
                .padding(.leading, 12)
                .onTapGesture {
                    viewModel.callToPlace(placeModel.phone)
                }
                Spacer()
            }
            Spacer().frame(height: 12)
        }
        .frame(width: UIScreen.main.bounds.width * 0.7, height: 103)
        .background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(16)
        .shadow(color: .cardShadowColor, radius: 3, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.primaryRed, lineWidth: viewModel.isSelectedCard(index) ? 2 : 0)
        )
        .onTapGesture {
            viewModel.isSelectedCard(index) ? viewModel.showSafari.toggle() : viewModel.slideCard(index)
        }
        .fullScreenCover(isPresented: $viewModel.showSafari, content: {
            SafariView(url: viewModel.getURL())
                .edgesIgnoringSafeArea(.all)
        })
    }
}

//struct CardContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardContentView()
//    }
//}
