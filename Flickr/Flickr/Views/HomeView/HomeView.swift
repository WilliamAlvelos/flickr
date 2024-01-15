//
//  HomeView.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            switch viewModel.status {
            case .empty:
                FLEmptyView()
            case .error(let error):
                FlickrErrorView(errorMessage: error.localizedDescription) {
                    viewModel.loadFirstPage()
                }
            case .loading:
                FlickrLoaderView()
            case .loaded:
                GeometryReader { geometry in
                    List {
                        Section {
                            ForEach(viewModel.photos, id: \.identifier) { photo in
                                PhotoView(photo: photo, screenWidth: geometry.size.width, userPhotoTapGesture: {
                                    viewModel.presentUserProfile(owner: photo.owner)
                                })
                                .listRowSeparator(.hidden)
                                .onTapGesture {
                                    viewModel.presentPhoto(photo: photo)
                                }
                            }
                        } footer: {
                            LastRowView(viewModel: viewModel)
                        }

                    }
                }
            }
        }.refreshable {
            viewModel.loadFirstPage()
        }.onFirstAppear {
            viewModel.loadFirstPage()
        }
        .navigationTitle("Flickr")
        .listStyle(.plain)
        .searchable(text: $viewModel.searchText)
        .onSubmit(of: .search) {
            viewModel.loadFirstPage()
        }
    }
}
