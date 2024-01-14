//
//  UserDetailView.swift
//  Flickr
//
//  Created by William de Alvelos on 12/01/2024.
//

import SwiftUI

struct UserDetailView: View {
    
    @StateObject var viewModel: UserDetailViewModel
    
    var body: some View {
        switch viewModel.status {
        case .empty:
            FLEmptyView()
        case .error(let error):
            FlickrErrorView(errorMessage: error.localizedDescription) {
                viewModel.fetchPhotosAndUserDetails()
            }
        case .loaded, .loading:
            GeometryReader { geometry in
                List {
                    if let person = viewModel.person {
                        ProfileView(person: person, screenWidth: geometry.size.width)
                    }
                    
                    ForEach(viewModel.photos) { photo in
                        ImageView(imageURL: photo.photoURL, contentMode: .fill)
                            .frame(width: geometry.size.width)
                            .clipped()
                            .listRowSeparator(.hidden)
                    }
                }
            }.refreshable {
                viewModel.fetchPhotosAndUserDetails()
            }.onFirstAppear {
                viewModel.fetchPhotosAndUserDetails()
            }
            .navigationTitle(viewModel.person?.username._content ?? "")
            .listStyle(.plain)
        }
    }
    
}
