//
//  MainView.swift
//  Gollabab
//
//  Created by Harry on 2022/05/02.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel = MainViewModel()
    @State private var keyword: String = ""
    @State var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            MainMapView(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    viewModel.checkPermisson()
                }
            
            VStack {
                ZStack {
                    TextField("검색해주세요.", text: $keyword)
                        .padding(15)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 17))
                        Spacer().frame(width: 30)
                    }
                }
                .frame(height: 40)
                
//                ScrollView(.horizontal, showsIndicators: false, content: {
//                    HStack(spacing: 0) {
//
//                        ForEach(0..<10) { i in
//                            Text("\(i)")
//                                .frame(width: 50, height: 30)
//                                .background(Color.white)
//                                .cornerRadius(5)
//                                .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
//                                .padding(10)
//                        }
//                    }
//                    .padding(.leading, 20)
//                })
                    
                Spacer()
                PlaceCardView(viewModel: viewModel, index: $currentIndex)
                    .frame(height: 103)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
