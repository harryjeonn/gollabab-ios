//
//  ResultCardView.swift
//  Gollabab
//
//  Created by 전현성 on 2022/07/17.
//

import SwiftUI

struct ResultCardView: View {
    @ObservedObject var viewModel: MainViewModel
    @State var showSafari: Bool = false
    
    var place: PlaceModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack {
                VStack {
                    HStack {
                        Text("오늘은\n\(viewModel.getCategory(place.categoryName).rawValue)\n먹어밥")
                            .font(.aggroTitle())
                            .foregroundColor(.selectedRed)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 24)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Image(viewModel.getCategory(place.categoryName).image())
                            .resizable()
                            .frame(width: 120, height: 120)
                            .opacity(0.4)
                    }
                    .padding(.top, -70)
                }
                .background(Color.primaryBeige)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("\(place.placeName)")
                            .font(.eliceP1())
                            .foregroundColor(.text300)
                        
                        Image("chevron_right_outline")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .padding(.top, 32)
                    
                    Text(viewModel.convertCategory(place.categoryName))
                        .font(.eliceP4())
                        .foregroundColor(.gray500)
                        .padding(.top, 12)
                    
                    HStack(spacing: 0) {
                        Image("pin_card")
                            .resizable()
                            .frame(width: 14, height: 14)
                        
                        Text(viewModel.getDistance(lat: place.latY, lon: place.lonX))
                            .font(.eliceCaption())
                            .foregroundColor(.gray500)
                            .padding(.leading, 4)
                        
                        Image(place.phone.isEmpty ? "phone_disable" : "phone")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .padding(.leading, 16)
                            .padding(.trailing, 4)
                        
                        if place.phone.isEmpty {
                            Text("통화불가")
                                .font(.eliceCaption())
                                .foregroundColor(.gray500)
                        } else {
                            Text("전화걸기")
                                .font(.eliceCaption())
                                .foregroundColor(.primaryRed)
                                .underline()
                                .onTapGesture {
                                    viewModel.callToPlace(place.phone)
                                }
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 16)
                }
                .padding(.leading, 16)
            }
            .overlay(RoundedRectangle(cornerRadius: 6)
                .stroke(Color.secondaryRed, lineWidth: 2))
            .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
        }
        .onTapGesture {
            showSafari = true
        }
        .fullScreenCover(isPresented: $showSafari, content: {
            SafariView(url: viewModel.getURL(place.placeUrl))
                .edgesIgnoringSafeArea(.all)
        })
    }
}

//struct ResultCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultCardView()
//    }
//}
