//
//  SearchView.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel

    var body: some View {
        VStack {
            Picker(selection: $viewModel.searchType, label: Text("Search Type")) {
                Text("Search.Type.Photos").tag(SearchType.photos)
                Text("Search.Type.Tags").tag(SearchType.tags)
                Text("Search.Type.Groups").tag(SearchType.groups)
            }
            .pickerStyle(.segmented)
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            Spacer()
            
            VStack {
                switch viewModel.status {
                case .empty:
                    FLEmptyView(type: viewModel.searchType.emptyViewType)
                case .error(let error):
                    FlickrErrorView(errorMessage: error.localizedDescription) {
                        viewModel.search()
                    }
                case .loading:
                    FlickrLoaderView()
                case .loaded:
                    switch viewModel.searchType {
                    case .photos, .tags:
                        GeometryReader { geometry in
                            List(viewModel.content) { photo in
                                PhotoView(photo: photo, screenWidth: geometry.size.width)
                                    .onAppear() {
                                        viewModel.loadNextPage()
                                    }.listRowSeparator(.hidden)
                                    .onTapGesture {
                                        viewModel.presentPhoto(photo: photo)
                                    }
                            }
                        }.refreshable {
                            viewModel.search()
                        }.listStyle(.plain)
                        
                    case .groups:
                        List(viewModel.groups) { group in
                            Text(group.name)
                            .onTapGesture {
                                viewModel.presentGroup(group: group)
                            }
                        }
                    }
                }
            }
        }.searchable(text: $viewModel.searchText, 
                     prompt: viewModel.searchType.searchPlaceholder)
        .navigationTitle("NavigationTitle.Search")
        .onSubmit(of: .search) {
            viewModel.search()
        }
    }
}
