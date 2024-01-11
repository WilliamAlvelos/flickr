//
//  HomeView.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State private var searchText = "yorkshire"
    @State private var searchType = 0

    var body: some View {
        NavigationView {
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
                    EmptyView()
                case .loaded, .loading:
                    List(viewModel.photos) { photos in
                        ImageView(imageURL: photos.photoURL)
                            .frame(maxWidth: .infinity)
                    }.refreshable {
                        viewModel.searchPhotos(text: searchText)
                    }
                }
            }
        }.searchable(text: $searchText)
        .navigationTitle("Flickr")
        .onSubmit(of: .search) {
            viewModel.searchPhotos(text: searchText)
        }
    }
}

#Preview {
    HomeView()
}
