//
//  ResultCardView.swift
//  Gollabab
//
//  Created by 전현성 on 2022/07/17.
//

import SwiftUI

struct ResultCardView: View {
    var place: PlaceModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack {
                VStack {
                    HStack {
                        Text("오늘은\n일식\n먹어밥")
                            .font(.eliceBold(size: 32))
                            .foregroundColor(.selectedRed)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 26)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Image("icon_japanese")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .opacity(0.4)
                    }
                    .padding(.top, -70)
                }
                .background(Color.primaryBeige)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(place.placeName) >")
                        .font(.eliceP1())
                        .foregroundColor(.text200)
                        .padding(.top, 32)
                    
                    Text("#한식 #김치찌개")
                        .font(.eliceP4())
                        .foregroundColor(.gray500)
                        .padding(.top, 12)
                    
                    HStack(spacing: 0) {
                        Image("pin_card")
                            .resizable()
                            .frame(width: 14, height: 14)
                        
                        Text("\(place.distance)m")
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
                                    // 전화걸기
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
    }
}

//struct ResultCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultCardView()
//    }
//}
