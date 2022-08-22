//
//  MainView.swift
//  Gollabab
//
//  Created by Harry on 2022/05/02.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @State var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            MainMapView(viewModel: viewModel)
                .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        SearchView(viewModel: viewModel)
                            .padding(.leading, 22)
                        
                        Spacer()
                        
                        VStack(spacing: 0) {
                            Image(viewModel.isList ? "map_fill" : "list_outline")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            Text(viewModel.isList ? "지도" : "목록")
                                .font(.eliceCaptionSmall())
                                .foregroundColor(.primaryRed)
                        }
                        .padding(.leading, 16)
                        .padding(.trailing, 28)
                        .onTapGesture {
                            viewModel.isList.toggle()
                            viewModel.dismissRecentSearchView()
                        }
                    }
                    
                    CategoryView(viewModel: viewModel)
                    Rectangle()
                        .foregroundColor(.gray700)
                        .frame(height: 0.5)
                        .frame(minWidth: .zero, maxWidth: .infinity)
                }
                .padding(.top, 52)
                .background(Color.white)
                
                if viewModel.isEditing {
                    RecentSearchView(viewModel: viewModel)
                        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
                        .background(Color.white)
                } else {
                    if viewModel.isList {
                        PlaceListView(viewModel: viewModel)
                            .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
                            .background(Color.white)
                    } else {
                        if viewModel.isShowCurrentMapResearch && viewModel.previousIsRandom == false {
                            Button {
                                viewModel.fetchCurrentMapPoint()
                            } label: {
                                Text("여기서 찾아밥")
                                    .font(.eliceCaption())
                                    .foregroundColor(.primaryBeige)
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .background(Color.black)
                                    .cornerRadius(10)
                                    .shadow(color: .cardShadowColor, radius: 3, x: 0, y: 2)
                            }
                            .padding(.top, 12)
                        }
                        
                        Spacer()
                        HStack {
                            Spacer()
                            
                            Image(viewModel.isActiveMyLocation ? "location_active" : "location_outline")
                                .frame(width: 42, height: 42)
                                .background(Color.white)
                                .clipShape(Circle())
                                .padding(.bottom, 24)
                                .padding(.trailing, 24)
                                .shadow(color: .cardShadowColor, radius: 3, x: 1, y: 1)
                                .onTapGesture {
                                    viewModel.moveToMyLocation()
                                }
                        }
                        
                        PlaceCardView(viewModel: viewModel, index: $currentIndex)
                            .background(Color.white.opacity(0.001))
                            .padding(.bottom, 24)
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .fullScreenCover(isPresented: $viewModel.showSafari, content: {
                SafariView(url: viewModel.getURL(viewModel.places[viewModel.touchedIndex].placeUrl))
                    .edgesIgnoringSafeArea(.all)
            })
            .onAppear {
                if viewModel.previousIsRandom {
                    viewModel.slideCard(viewModel.cardCurrentIndex)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
