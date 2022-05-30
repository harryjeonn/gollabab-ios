//
//  PlaceCardView.swift
//  Gollabab
//
//  Created by Harry on 2022/05/26.
//

import SwiftUI

struct PlaceCardView: View {
    var placeModel: PlaceModel
    
    var body: some View {
        VStack {
            Text(placeModel.placeName)
            Text(placeModel.addressName)
            Text(placeModel.categoryName)
        }
    }
}

//struct PlaceCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceCardView()
//    }
//}
