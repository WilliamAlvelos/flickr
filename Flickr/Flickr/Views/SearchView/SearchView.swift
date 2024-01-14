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
                Text("Search.Type.Tags").tag(SearchType.tags)
                Text("Search.Type.Users").tag(SearchType.user)
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
                    case .tags:
                        GeometryReader { geometry in
                            List(viewModel.photos) { photo in
                                PhotoView(photo: photo,
                                          screenWidth: geometry.size.width,
                                          userPhotoTapGesture: {
                                    viewModel.presentPerson(person: photo.owner)
                                })
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
                        
                    case .user:
                        List(viewModel.people) { person in
                            SearchPersonView(person: person)
                                .onTapGesture {
                                    viewModel.presentPerson(person: person.nsid)
                                }
                        }
                    case .groups:
                        List(viewModel.groups) { group in
                            SearchGroupView(group: group)
                            .onTapGesture {
                                viewModel.presentGroup(group: group)
                            }
                        }
                    }
                }
            }
            Spacer()
        }.searchable(text: $viewModel.searchText,
                     prompt: viewModel.searchType.searchPlaceholder)
        .navigationTitle("NavigationTitle.Search")
        .onSubmit(of: .search) {
            viewModel.search()
        }
    }
}
