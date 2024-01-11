//
//  HomeView.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        switch viewModel.status {
        case .empty:
            EmptyView()
        case .error(let error):
            FlickrErrorView(errorMessage: error.localizedDescription) {
                viewModel.searchPhotos()
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
                        VStack(alignment: .leading) {
                            Text(photos.title)
                                .font(.callout)
                            Text(photos.owner)
                                .font(.footnote)
                        }
                    }
                }
            }.refreshable {
                viewModel.searchPhotos()
            }.listStyle(.plain)
            .navigationTitle("Yorkshire")
            .onAppear {
                viewModel.searchPhotos()
            }
        }
    }
}
