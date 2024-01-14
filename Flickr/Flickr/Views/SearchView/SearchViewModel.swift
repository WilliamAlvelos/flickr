//
//  SearchViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation
import Combine

//final class SearchContentViewModel<T: Codable>: ObservableObject {
//    @Published var status: Status = .empty
//    @Published var content: [Group] = []
//        
//    private var cancellable: Set<AnyCancellable> = []
//    private let repository: FlickrRepositoryProtocol
//    private let coordinator: SearchViewWireframe
//    
//    private var page: Page = Page(page: 1)
//    private var isLoadingNewPage = false
//    
//    private var currentSearch: String = ""
//    
//    init(repository: FlickrRepositoryProtocol, coordinator: SearchViewWireframe) {
//        self.repository = repository
//        self.coordinator = coordinator
//    }
//}


final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchType: SearchType = SearchType.tags
    
    private let repository: FlickrRepositoryProtocol
    private let coordinator: SearchViewWireframe
    
    var userViewModel: UserSearchViewModel
    var tagsViewModel: TagsSearchViewModel
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
            tagsViewModel.search(tags: searchText)
        case .user:
            userViewModel.search(userName: searchText)
        case .groups:
            groupsViewModel.search(text: searchText)
        }
    }
}
