//
//  PlaceListView.swift
//  Gollabab
//
//  Created by Harry on 2022/06/08.
//

import SwiftUI

struct PlaceListView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var selection = Set<UUID>()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("총 \(viewModel.places.count)개")
                    .font(.eliceP3())
                    .padding(.leading, 22)
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(Array(viewModel.places.enumerated()), id: \.0) { idx, place in
                    viewModel.createPlaceList(place: place, index: idx)
                }
            }
            
            Spacer()
        }
        .padding(.top, 16)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(viewModel: MainViewModel())
    }
}
