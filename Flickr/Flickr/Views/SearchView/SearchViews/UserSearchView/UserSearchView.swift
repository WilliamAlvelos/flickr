//
//  UserSearchView.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import SwiftUI

struct UserSearchView: View {
    @StateObject var viewModel: SearchContentViewModel<SearchPerson>
    
    var body: some View {
        VStack {
            switch viewModel.status {
            case .empty:
                FLEmptyView(type: SearchType.user.emptyViewType)
            case .error(let error):
                FlickrErrorView(errorMessage: error.localizedDescription) {
                    viewModel.tryAgain()
                }
            case .loading:
                FlickrLoaderView()
            case .loaded:
                List {
                    Section {
                        ForEach(viewModel.content) { person in
                            SearchPersonView(person: person)
                                .onTapGesture {
                                    viewModel.presentPerson(person: person.nsid)
                                }
                        }
                    } footer: {
                        lastRowView
                    }
                }
            }
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
