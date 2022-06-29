//
//  MainView.swift
//  Gollabab
//
//  Created by Harry on 2022/05/02.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel = MainViewModel()
    @State var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            MainMapView(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    viewModel.checkPermisson()
                }
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Spacer().frame(width: 20)
                        
                        SearchView(viewModel: viewModel)
                        
                        Spacer()
                        
                        VStack {
                            Image("list_outline")
                                .frame(width: 24, height: 24)
                            
                            Text("목록")
                                .font(.eliceCaptionSmall())
                                .foregroundColor(.primaryRed)
                        }
                        .padding(.leading, 20)
                        .onTapGesture {
                            viewModel.isList.toggle()
                        }
                        
                        Spacer().frame(width: 20)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 16) {
                            CategoryView(viewModel: viewModel)
                        }
                        .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
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
