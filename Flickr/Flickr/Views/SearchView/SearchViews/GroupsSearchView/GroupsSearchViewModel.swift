//
//  GroupsSearchViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation
import Combine

final class GroupsSearchViewModel: SearchContentViewModel<Group> {
    override func search() {
        searchGroups()
    }
    
    func searchGroups() {
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
                    self.content = response.groups.group

                } else {
                    self.content += response.groups.group
                    self.isLoadingNewPage = false
                }
                self.status = .loaded
            }.store(in: &cancellables)
    }
}
