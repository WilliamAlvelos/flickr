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
                switch viewModel.searchType {
                case .tags:
                    TagsSearchView(viewModel: viewModel.tagsViewModel)
                case .user:
                    UserSearchView(viewModel: viewModel.userViewModel)
                case .groups:
                    GroupsSearchView(viewModel: viewModel.groupsViewModel)
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
