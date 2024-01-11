//
//  SearchView.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State private var searchText = ""
    @State private var searchType = 0

    var body: some View {
        VStack {
            Picker(selection: $searchType, label: Text("Search Type")) {
                Text("Photos").tag(0)
                Text("Users").tag(1)
                Text("Tags").tag(2)
            }
            .pickerStyle(.segmented)
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            
            switch viewModel.status {
            case .empty:
                EmptyView()
            case .error(let error):
                FlickrErrorView(errorMessage: error.localizedDescription) {
                    viewModel.searchPhotos(text: searchText)
                }
            case .loaded, .loading:
                List(viewModel.photos) { photos in
                    VStack(alignment: .leading) {
                        ImageView(imageURL: photos.photoURL)
                            .frame(maxWidth: .infinity)
                        HStack {
                            ImageView(imageURL: photos.ownerPhotoURL)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.secondaryPink.gradient,
                                                         lineWidth: 1))
                                .shadow(radius: 3)
                            
                            Text(photos.owner)
                                .font(.footnote)
                        }
                    }
                }.refreshable {
                    viewModel.searchPhotos(text: searchText)
                }.listStyle(.plain)
            }
        }.searchable(text: $searchText)
        .navigationTitle("Search")
        .onSubmit(of: .search) {
            viewModel.searchPhotos(text: searchText)
        }
    }
}
