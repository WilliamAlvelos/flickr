//
//  GroupsSearchViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation
import Combine
import SwiftUI

final class GroupsSearchViewModel: ObservableObject {
    @Published var status: Status = .empty
    @Published var groups: [Group] = []
        
    private var cancellable: Set<AnyCancellable> = []
    private let repository: FlickrRepositoryProtocol
    private let coordinator: SearchViewWireframe
    
    private var page: Page = Page(page: 1)
    private var isLoadingNewPage = false
    
    private var currentSearch: String = ""
    
    init(repository: FlickrRepositoryProtocol, coordinator: SearchViewWireframe) {
        self.repository = repository
        self.coordinator = coordinator
    }
}

// MARK:  Public Methods

extension GroupsSearchViewModel {
    func search(text: String) {
        currentSearch = text
        page.reset()
        searchGroups()
    }
    
    func tryAgain() {
        searchGroups()
    }
    
    func loadMoreIfNeeded() {
        if isLoadingNewPage {
            return
        }
        isLoadingNewPage = true
        
        page.nextPage()
        searchGroups()
    }
    
    // MARK:  Coordinator
    func presentGroup(group: Group) {
        coordinator.presentGroup(group: group)
    }
}

// MARK:  Private Methods

extension GroupsSearchViewModel {
    
    private func searchGroups() {

        print("------------- PAGE \(page) -----------------")
        if page.page == 1 {
            self.status = .loading
        }
        
        repository.searchGroupsBy(text: currentSearch, page: page)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.status = .error(error: error)
                }
            } receiveValue: { response in
                guard !response.groups.group.isEmpty else {
                    self.status = .empty
                    return
                }
                
                if response.groups.page == 1 {
                    self.groups = response.groups.group

                } else {
                    self.groups += response.groups.group
                    self.isLoadingNewPage = false
                }
                self.status = .loaded
            }.store(in: &cancellable)
    }
}
