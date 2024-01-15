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
        VStack {
            switch viewModel.status {
            case .empty:
                GeometryReader { geometry in
                    if let person = viewModel.person {
                        ProfileView(person: person, screenWidth: geometry.size.width)
                    }
                }
                
                FLEmptyView()
            case .error(let error):
                FlickrErrorView(errorMessage: error.localizedDescription) {
                    viewModel.fetchPhotosAndUserDetails()
                }
            case .loading:
                FlickrLoaderView()
            case .loaded:
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
                    }.listStyle(.plain)
                }.refreshable {
                    viewModel.fetchPhotosAndUserDetails()
                }
            }
        }.onFirstAppear {
            viewModel.fetchPhotosAndUserDetails()
        }
        .navigationTitle(viewModel.person?.username._content ?? "")
    }
}
