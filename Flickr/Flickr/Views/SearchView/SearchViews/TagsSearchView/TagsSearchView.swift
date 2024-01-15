//
//  TagsSearchView.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import SwiftUI

struct TagsSearchView: View {
    @StateObject var viewModel: TagsSearchViewModel
    @State private var showingActionSheet = false
        
    var body: some View {
        VStack {
            switch viewModel.status {
            case .empty:
                FLEmptyView(type: SearchType.tags.emptyViewType)
            case .error(let error):
                FlickrErrorView(errorMessage: error.localizedDescription) {
                    viewModel.tryAgain()
                }
            case .loading:
                FlickrLoaderView()
            case .loaded:
                GeometryReader { geometry in
                    List {
                        Section {
                            ForEach(viewModel.content, id: \.identifier) { photo in
                                PhotoView(photo: photo,
                                          screenWidth: geometry.size.width,
                                          userPhotoTapGesture: {
                                    viewModel.presentPerson(person: photo.owner)
                                })
                                .listRowSeparator(.hidden)
                                .onTapGesture {
                                    viewModel.presentPhoto(photo: photo)
                                }
                            }
                        } footer: {
                            lastRowView
                        }
                    }.listStyle(.plain)
                }
            }
        }.navigationBarItems(trailing:
            Button(action: {
                showingActionSheet.toggle()
            }) {
                Image(systemName: "line.3.horizontal.decrease.circle")
            }
        ).actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(
                title: Text("Search.FilterTags.Title"),
                message: Text("Search.FilterTags.Message"),
                buttons: [
                    .default(Text("Search.FilterTags.Any")) {
                        viewModel.tagMode = .any
                    },
                    .default(Text("Search.FilterTags.All")) {
                        viewModel.tagMode = .all
                    },
                    .cancel()
                ]
            )
        }
    }
    
    var lastRowView: some View {
        HStack(alignment: .center) {
            Spacer()
            ProgressView()
            Spacer()
        }
        .frame(height: 50)
        .onAppear {
            if viewModel.status == .loaded {
                viewModel.loadMoreIfNeeded()
            }
        }
    }
}
