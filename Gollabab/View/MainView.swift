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
    
    var testItems = ["전체", "🍚 한식", "🍜 중식", "🍣 일식", "🍝 양식", "🍤 분식", "🍔 패스트푸드", "🌮 아시안음식", "☕️ 카페", "🍰 간식"]
    
    var body: some View {
        ZStack {
            MainMapView(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    viewModel.checkPermisson()
                }
            
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Spacer().frame(width: 20)
                        
                        TextField("오늘은 어떤밥?", text: $keyword)
                            .font(.eliceP3())
                            .padding(.leading, 12)
                            .frame(height: 40)
                            .background(Color.selectedTextColor)
                            .cornerRadius(12)
                        
                        Spacer()
                        
                        VStack {
                            Image(systemName: "list.dash")
                                .font(.system(size: 17))
                                .frame(width: 24, height: 24)
                            
                            Text("목록")
                                .font(.eliceCaptionSmall())
                        }
                        .padding(.leading, 20)
                        .onTapGesture {
                            viewModel.isList.toggle()
                        }
                        
                        Spacer().frame(width: 20)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 0) {
                            
                            ForEach(0..<testItems.count) { item in
                                Text("\(testItems[item])")
                                    .font(.eliceP4())
                                    .frame(height: 30)
                                    .padding(12)
                                    .background(Color.white)
                                    .cornerRadius(5)
                            }
                        }
                        .padding(.leading, 20)
                    })
                }
                .padding(.top, 52)
                .background(Color.white)
                
                if viewModel.isList {
                    PlaceListView(viewModel: viewModel)
                        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
                        .background(Color.white)
                } else {
                    Spacer()
                    PlaceCardView(viewModel: viewModel, index: $currentIndex)
                        .frame(height: 103)
                        .padding(.bottom, 24)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
