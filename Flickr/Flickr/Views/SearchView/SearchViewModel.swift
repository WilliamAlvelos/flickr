//
//  SearchViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Combine

final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchType: SearchType = SearchType.tags
    
    private let repository: FlickrRepositoryProtocol
    private let coordinator: SearchViewWireframe
    
    var tagsViewModel: TagsSearchViewModel
    var userViewModel: UserSearchViewModel
    var groupsViewModel: GroupsSearchViewModel
    
    init(repository: FlickrRepositoryProtocol, coordinator: SearchViewWireframe) {
        self.repository = repository
        self.coordinator = coordinator
        
        tagsViewModel = TagsSearchViewModel(repository: repository,
                                            coordinator: coordinator)
        
        userViewModel = UserSearchViewModel(repository: repository,
                                            coordinator: coordinator)
        
        groupsViewModel = GroupsSearchViewModel(repository: repository,
                                                coordinator: coordinator)
    }
}

// MARK:  Public Methods

extension SearchViewModel {
    func search() {
        switch searchType {
        case .tags:
            tagsViewModel.search(text: searchText)
        case .user:
            userViewModel.search(text: searchText)
        case .groups:
            groupsViewModel.search(text: searchText)            
        }
    }
}
