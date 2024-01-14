//
//  GroupsSearchView.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import SwiftUI

struct GroupsSearchView: View {
    @StateObject var viewModel: SearchContentViewModel<Group>
    
    var body: some View {
        VStack {
            switch viewModel.status {
            case .empty:
                FLEmptyView(type: SearchType.groups.emptyViewType)
            case .error(let error):
                FlickrErrorView(errorMessage: error.localizedDescription) {
                    viewModel.tryAgain()
                }
            case .loading:
                FlickrLoaderView()
            case .loaded:
                List {
                    Section {
                        ForEach(viewModel.content, id: \.identifier) { group in
                            SearchGroupView(group: group)
                                .onTapGesture {
                                    viewModel.presentGroup(group: group)
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
